import uvicorn
import os
from dotenv import load_dotenv

# .env 파일이 있으면 환경 변수 로드
load_dotenv()

# 기본 설정값
DEFAULT_HOST = "0.0.0.0"
DEFAULT_PORT = 8000
DEFAULT_RELOAD = False

if __name__ == "__main__":
    # 환경 변수에서 설정 가져오기 (또는 기본값 사용)
    host = os.getenv("HOST", DEFAULT_HOST)
    port = int(os.getenv("PORT", DEFAULT_PORT))
    reload = os.getenv("RELOAD", "False").lower() in ("true", "1", "t")
    
    print(f"웹소켓 서버를 시작합니다...")
    print(f"호스트: {host}")
    print(f"포트: {port}")
    print(f"자동 리로드: {'활성화' if reload else '비활성화'}")
    
    # Uvicorn 서버 실행
    uvicorn.run(
        "main:app",
        host=host,
        port=port,
        reload=reload
    ) 