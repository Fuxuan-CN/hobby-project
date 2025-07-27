from fastapi import FastAPI
from utils import logger 
import uvicorn
from api.user_controller import user_router
from contextlib import asynccontextmanager

HOST = "0.0.0.0"
PORT = 8000

@asynccontextmanager
async def lifespan(app: FastAPI):
    logger.info(f"Starting server on {HOST}:{PORT}")
    yield
    logger.info("Server stop")

app = FastAPI(lifespan=lifespan)

app.include_router(user_router)

def run() -> None:
    uvicorn.run(app, host=HOST, port=PORT, log_level="critical")

if __name__ == "__main__":
    run()
