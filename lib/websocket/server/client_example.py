import asyncio
import json
import websockets
import sys

# 웹소켓 클라이언트 예제
async def websocket_client():
    # 클라이언트 ID 입력
    if len(sys.argv) > 1:
        client_id = sys.argv[1]
    else:
        client_id = input("클라이언트 ID를 입력하세요: ")
    
    # 웹소켓 서버 연결
    uri = f"ws://localhost:8000/ws/{client_id}"
    
    print(f"{client_id}로 서버에 연결을 시도합니다...")
    
    async with websockets.connect(uri) as websocket:
        print("서버에 연결되었습니다!")
        
        # 수신 태스크 생성
        receive_task = asyncio.create_task(receive_messages(websocket))
        
        # 송신 태스크 생성
        send_task = asyncio.create_task(send_messages(websocket, client_id))
        
        # 둘 중 하나라도 완료되면 종료
        done, pending = await asyncio.wait(
            [receive_task, send_task],
            return_when=asyncio.FIRST_COMPLETED,
        )
        
        # 남은 태스크 취소
        for task in pending:
            task.cancel()

# 메시지 수신 함수
async def receive_messages(websocket):
    try:
        while True:
            message = await websocket.recv()
            print(f"\n수신: {message}")
            print("메시지 입력 (대상ID:메시지): ", end="", flush=True)
    except websockets.ConnectionClosed:
        print("\n연결이 종료되었습니다.")
    except Exception as e:
        print(f"\n오류 발생: {e}")

# 메시지 송신 함수
async def send_messages(websocket, client_id):
    try:
        while True:
            # 메시지 입력 (형식: 대상ID:메시지)
            message_input = input("메시지 입력 (대상ID:메시지): ")
            
            # 입력 분석
            if ":" in message_input:
                target, message = message_input.split(":", 1)
                target = target.strip()
            else:
                # 콜론이 없으면 브로드캐스트로 처리
                target = "broadcast"
                message = message_input
            
            # 빈 메시지는 무시
            if not message.strip():
                continue
                
            # 메시지 데이터 생성
            data = {
                "sender": client_id,
                "message": message.strip(),
                "target": target
            }
            
            # 메시지 전송
            await websocket.send(json.dumps(data))
            
    except websockets.ConnectionClosed:
        print("\n연결이 종료되었습니다.")
    except Exception as e:
        print(f"\n오류 발생: {e}")

if __name__ == "__main__":
    try:
        asyncio.run(websocket_client())
    except KeyboardInterrupt:
        print("\n프로그램을 종료합니다.")
    except Exception as e:
        print(f"오류 발생: {e}") 