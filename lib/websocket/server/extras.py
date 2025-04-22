from fastapi import FastAPI, WebSocket, WebSocketDisconnect, Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from pydantic import BaseModel
from typing import Dict, List, Optional
import json
import time

# 보안 기능
security = HTTPBearer()

# 메시지 모델
class Message(BaseModel):
    sender: str
    message: str
    target: str = "broadcast"
    timestamp: float = None

# 방 관리 클래스
class RoomManager:
    def __init__(self):
        self.rooms: Dict[str, Dict[str, WebSocket]] = {}
        self.room_history: Dict[str, List[Message]] = {}
        
    def create_room(self, room_id: str):
        if room_id not in self.rooms:
            self.rooms[room_id] = {}
            self.room_history[room_id] = []
            return True
        return False
        
    def delete_room(self, room_id: str):
        if room_id in self.rooms:
            del self.rooms[room_id]
            del self.room_history[room_id]
            return True
        return False
    
    async def join_room(self, room_id: str, client_id: str, websocket: WebSocket):
        if room_id not in self.rooms:
            self.create_room(room_id)
        
        await websocket.accept()
        self.rooms[room_id][client_id] = websocket
        
    def leave_room(self, room_id: str, client_id: str):
        if room_id in self.rooms and client_id in self.rooms[room_id]:
            del self.rooms[room_id][client_id]
            # 방이 비었으면 삭제
            if not self.rooms[room_id]:
                self.delete_room(room_id)
            return True
        return False
    
    def add_message_to_history(self, room_id: str, message: Message):
        if room_id in self.room_history:
            # 현재 타임스탬프 추가
            if message.timestamp is None:
                message.timestamp = time.time()
            self.room_history[room_id].append(message)
            # 최대 100개까지만 저장
            if len(self.room_history[room_id]) > 100:
                self.room_history[room_id].pop(0)
    
    def get_room_history(self, room_id: str) -> List[Message]:
        if room_id in self.room_history:
            return self.room_history[room_id]
        return []
    
    async def broadcast_to_room(self, room_id: str, message: str, exclude_client_id: str = None):
        if room_id in self.rooms:
            for client_id, connection in self.rooms[room_id].items():
                if exclude_client_id != client_id:
                    await connection.send_text(message)
    
    async def send_personal_message_in_room(self, room_id: str, message: str, client_id: str):
        if room_id in self.rooms and client_id in self.rooms[room_id]:
            await self.rooms[room_id][client_id].send_text(message)
            return True
        return False

    def get_clients_in_room(self, room_id: str) -> List[str]:
        if room_id in self.rooms:
            return list(self.rooms[room_id].keys())
        return []

# 이 클래스를 FastAPI 앱에 통합하는 예시:
"""
room_manager = RoomManager()

@app.websocket("/ws/room/{room_id}/{client_id}")
async def websocket_room_endpoint(websocket: WebSocket, room_id: str, client_id: str):
    await room_manager.join_room(room_id, client_id, websocket)
    try:
        # 방 참가 알림
        await room_manager.broadcast_to_room(
            room_id, 
            json.dumps({"type": "join", "client_id": client_id, "message": f"{client_id}님이 입장했습니다."})
        )
        
        # 이전 대화 기록 전송
        history = room_manager.get_room_history(room_id)
        if history:
            await websocket.send_text(
                json.dumps({"type": "history", "messages": [msg.dict() for msg in history]})
            )
            
        while True:
            data = await websocket.receive_json()
            message = Message(
                sender=client_id,
                message=data.get("message", ""),
                target=data.get("target", "broadcast")
            )
            
            # 메시지 기록에 추가
            room_manager.add_message_to_history(room_id, message)
            
            # 타겟이 "broadcast"면 방의 모든 사용자에게 메시지 전송
            if message.target == "broadcast":
                await room_manager.broadcast_to_room(
                    room_id, 
                    json.dumps({"type": "message", **message.dict()})
                )
            else:
                # 특정 사용자에게만 메시지 전송
                success = await room_manager.send_personal_message_in_room(
                    room_id,
                    json.dumps({"type": "private", **message.dict()}),
                    message.target
                )
                # 발신자에게도 메시지가 전송되었음을 알림
                if success and client_id != message.target:
                    await room_manager.send_personal_message_in_room(
                        room_id,
                        json.dumps({
                            "type": "info", 
                            "message": f"{message.target}님에게 메시지 전송 완료: {message.message}"
                        }),
                        client_id
                    )
                
    except WebSocketDisconnect:
        # 연결이 끊기면 방에서 제거하고 다른 사용자들에게 알림
        room_manager.leave_room(room_id, client_id)
        await room_manager.broadcast_to_room(
            room_id, 
            json.dumps({"type": "leave", "client_id": client_id, "message": f"{client_id}님이 퇴장했습니다."})
        )
    except Exception as e:
        print(f"웹소켓 오류: {e}")
        room_manager.leave_room(room_id, client_id)
"""

# 간단한 JWT 토큰 인증 기능 (실제 구현을 위해선 python-jose 패키지 필요)
"""
from datetime import datetime, timedelta
from jose import JWTError, jwt
from passlib.context import CryptContext
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer

# 비밀키 설정 (실제 사용시 환경변수로 빼야 함)
SECRET_KEY = "your-secret-key"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

# 비밀번호 해싱
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# 가상의 사용자 DB
fake_users_db = {
    "testuser": {
        "username": "testuser",
        "hashed_password": pwd_context.hash("testpassword"),
    }
}

# 사용자 모델
class User(BaseModel):
    username: str

class UserInDB(User):
    hashed_password: str

# 비밀번호 검증
def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

# 사용자 확인
def get_user(db, username: str):
    if username in db:
        user_dict = db[username]
        return UserInDB(**user_dict)

# 사용자 인증
def authenticate_user(fake_db, username: str, password: str):
    user = get_user(fake_db, username)
    if not user:
        return False
    if not verify_password(password, user.hashed_password):
        return False
    return user

# JWT 토큰 생성
def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

# 토큰으로부터 현재 사용자 가져오기
async def get_current_user(token: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception
    user = get_user(fake_users_db, username=username)
    if user is None:
        raise credentials_exception
    return user

# 로그인 API 엔드포인트
@app.post("/token")
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends()):
    user = authenticate_user(fake_users_db, form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.username}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}
""" 