
from sqlalchemy.ext.asyncio import create_async_engine, AsyncEngine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from core.config import settings

# 创建数据库引擎
engine = create_async_engine(
    settings.DATABASE_URL,
    echo=settings.SQLALCHEMY_LOG,
    pool_pre_ping=settings.POOL_PRE_PING,
    pool_recycle=settings.POOL_RECYCLE
)

# 创建会话工厂
SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine, # type: ignore
    class_=AsyncEngine
)

# 基础模型类，所有模型都继承此类
Base = declarative_base()
