from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.responses import HTMLResponse
from typing import List, Dict
import uuid

app = FastAPI()

# 연결된 클라이언트들을 저장하는 클래스
class ConnectionManager:
    def __init__(self):
        # 활성화된 연결들을 저장할 딕셔너리
        self.active_connections: Dict[str, WebSocket] = {}
        
    async def connect(self, client_id: str, websocket: WebSocket):
        # 클라이언트 연결 수락
        await websocket.accept()
        # 클라이언트를 활성 연결 목록에 추가
        self.active_connections[client_id] = websocket
        
    def disconnect(self, client_id: str):
        # 연결 종료 시 목록에서 제거
        if client_id in self.active_connections:
            del self.active_connections[client_id]
    
    async def send_personal_message(self, message: str, client_id: str):
        # 특정 클라이언트에게만 메시지 보내기
        if client_id in self.active_connections:
            await self.active_connections[client_id].send_text(message)
    
    async def broadcast(self, message: str, exclude_client_id: str = None):
        # 모든 클라이언트에게 메시지 브로드캐스트 (특정 클라이언트 제외 가능)
        for client_id, connection in self.active_connections.items():
            if exclude_client_id != client_id:
                await connection.send_text(message)


manager = ConnectionManager()

# 간단한 HTML 페이지를 제공하는 엔드포인트
@app.get("/")
async def get():
    html = """
    <!DOCTYPE html>
    <html>
        <head>
            <title>WebSocket 테스트</title>
            <style>
                body { 
                    max-width: 600px; 
                    margin: 0 auto; 
                    padding: 20px; 
                    font-family: Arial, sans-serif;
                }
                #messageContainer { 
                    height: 300px; 
                    border: 1px solid #ccc; 
                    margin-bottom: 10px; 
                    padding: 10px; 
                    overflow-y: auto;
                }
                input, button { 
                    padding: 8px; 
                    margin-bottom: 10px;
                }
                input { width: 60%; }
                button { 
                    width: 30%; 
                    background-color: #4CAF50; 
                    color: white; 
                    border: none; 
                    cursor: pointer;
                }
                button:hover { background-color: #45a049; }
            </style>
        </head>
        <body>
            <h1>WebSocket 테스트</h1>
            <div id="messageContainer"></div>
            <div>
                <label for="clientId">클라이언트 ID:</label>
                <input type="text" id="clientId" placeholder="클라이언트 ID 입력">
                <button onclick="connect()">연결</button>
            </div>
            <div>
                <label for="messageText">메시지:</label>
                <input type="text" id="messageText" placeholder="메시지 입력">
                <button onclick="sendMessage()">전송</button>
            </div>
            <div>
                <label for="targetId">대상 ID:</label>
                <input type="text" id="targetId" placeholder="전송할 대상 ID (빈칸=전체)">
            </div>
            <script>
                var ws = null;
                var clientId = "";
                
                function connect() {
                    clientId = document.getElementById("clientId").value;
                    if (!clientId) {
                        alert("클라이언트 ID를 입력하세요");
                        return;
                    }
                    
                    if (ws) {
                        ws.close();
                    }
                    
                    ws = new WebSocket(`ws://localhost:8000/ws/${clientId}`);
                    
                    ws.onopen = function(event) {
                        addMessage("WebSocket 연결 성공");
                    };
                    
                    ws.onmessage = function(event) {
                        addMessage(`받은 메시지: ${event.data}`);
                    };
                    
                    ws.onclose = function(event) {
                        addMessage("WebSocket 연결 종료");
                    };
                    
                    ws.onerror = function(event) {
                        addMessage("WebSocket 오류 발생");
                        console.error(event);
                    };
                }
                
                function sendMessage() {
                    if (!ws) {
                        alert("먼저 WebSocket에 연결하세요");
                        return;
                    }
                    
                    const messageText = document.getElementById("messageText").value;
                    const targetId = document.getElementById("targetId").value;
                    
                    if (!messageText) {
                        alert("메시지를 입력하세요");
                        return;
                    }
                    
                    const data = {
                        sender: clientId,
                        message: messageText,
                        target: targetId || "broadcast"
                    };
                    
                    ws.send(JSON.stringify(data));
                    addMessage(`보낸 메시지: ${messageText} (대상: ${targetId || "전체"})`);
                    document.getElementById("messageText").value = "";
                }
                
                function addMessage(message) {
                    const messageContainer = document.getElementById("messageContainer");
                    const messageElement = document.createElement("div");
                    messageElement.innerText = message;
                    messageContainer.appendChild(messageElement);
                    messageContainer.scrollTop = messageContainer.scrollHeight;
                }
            </script>
        </body>
    </html>
    """
    return HTMLResponse(content=html)

# 웹소켓 엔드포인트
@app.websocket("/ws/{client_id}")
async def websocket_endpoint(websocket: WebSocket, client_id: str):
    await manager.connect(client_id, websocket)
    try:
        while True:
            # 메시지 수신
            data = await websocket.receive_json()
            sender = data.get("sender", "anonymous")
            message = data.get("message", "")
            target = data.get("target", "broadcast")
            
            # 타겟이 "broadcast"면 모든 사용자에게 메시지 전송
            if target == "broadcast":
                await manager.broadcast(f"{sender}님의 메시지: {message}")
            else:
                # 특정 사용자에게만 메시지 전송
                await manager.send_personal_message(f"{sender}님의 개인 메시지: {message}", target)
                # 발신자에게도 메시지가 전송되었음을 알림
                if sender != target:
                    await manager.send_personal_message(f"{target}님에게 메시지 전송 완료: {message}", sender)
                
    except WebSocketDisconnect:
        # 연결이 끊기면 관리자에서 제거하고 다른 사용자들에게 알림
        manager.disconnect(client_id)
        await manager.broadcast(f"{client_id}님이 퇴장했습니다")
    except Exception as e:
        print(f"웹소켓 오류: {e}")
        manager.disconnect(client_id)

# 클라이언트 ID가 없는 기본 웹소켓 엔드포인트 추가
@app.websocket("/ws")
async def default_websocket_endpoint(websocket: WebSocket):
    # 자동으로 생성된 클라이언트 ID 사용
    client_id = f"guest-{str(uuid.uuid4())[:8]}"
    
    await manager.connect(client_id, websocket)
    try:
        # 클라이언트에게 자동 생성된 ID 알림
        await websocket.send_text(f"자동 생성된 ID: {client_id}")
        
        while True:
            # 메시지 수신
            data = await websocket.receive_json()
            sender = data.get("sender", client_id)
            message = data.get("message", "")
            target = data.get("target", "broadcast")
            
            # 타겟이 "broadcast"면 모든 사용자에게 메시지 전송
            if target == "broadcast":
                await manager.broadcast(f"{sender}님의 메시지: {message}")
            else:
                # 특정 사용자에게만 메시지 전송
                await manager.send_personal_message(f"{sender}님의 개인 메시지: {message}", target)
                # 발신자에게도 메시지가 전송되었음을 알림
                if sender != target:
                    await manager.send_personal_message(f"{target}님에게 메시지 전송 완료: {message}", sender)
                
    except WebSocketDisconnect:
        # 연결이 끊기면 관리자에서 제거하고 다른 사용자들에게 알림
        manager.disconnect(client_id)
        await manager.broadcast(f"{client_id}님이 퇴장했습니다")
    except Exception as e:
        print(f"웹소켓 오류: {e}")
        manager.disconnect(client_id)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000) 