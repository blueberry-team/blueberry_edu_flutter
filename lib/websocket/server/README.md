# FastAPI 웹소켓 서버

FastAPI를 사용한 간단한 웹소켓 채팅 서버입니다.

## 기능

- 실시간 메시지 전송
- 1:1 개인 메시지 전송
- 브로드캐스트 메시지 전송 (모든 사용자에게)
- 사용자 연결 상태 관리

## 설치 방법

1. 필요한 패키지 설치:
```
pip install -r requirements.txt
```

2. 서버 실행:
```
python main.py
```

## 사용 방법

1. 웹브라우저에서 `http://localhost:8000`으로 접속합니다.
2. 클라이언트 ID를 입력하고 '연결' 버튼을 클릭합니다.
3. 메시지를 입력하고, 필요시 대상 ID를 지정합니다:
   - 대상 ID를 지정하면 해당 사용자에게만 메시지가 전송됩니다.
   - 대상 ID를 비워두면 모든 사용자에게 메시지가 전송됩니다.

## API 엔드포인트

- `GET /`: 웹소켓 테스트용 HTML 페이지 제공
- `WebSocket /ws/{client_id}`: 웹소켓 연결 엔드포인트

## 주요 API 및 구현 방법

```python
# 웹소켓 연결 설정
@app.websocket("/ws/{client_id}")

# 메시지 전송 형식 (JSON)
{
  "sender": "사용자ID",
  "message": "메시지 내용",
  "target": "대상ID 또는 broadcast"
}
```

## 웹소켓 클라이언트 예제 (JavaScript)

```javascript
// 연결
const ws = new WebSocket(`ws://localhost:8000/ws/client-id`);

// 메시지 수신
ws.onmessage = function(event) {
  console.log('메시지 수신:', event.data);
};

// 메시지 전송
ws.send(JSON.stringify({
  sender: "client-id",
  message: "안녕하세요!",
  target: "broadcast" // 또는 특정 사용자 ID
}));
```

## 라이선스

MIT License 