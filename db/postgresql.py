from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from core.config import settings

# 创建数据库引擎
engine = create_engine(
    settings.DATABASE_URL,
    echo=True,  # 生产环境设为False，避免打印SQL日志
    pool_pre_ping=True,  # 连接前检查有效性
    pool_recycle=300  # 连接5分钟后自动回收，避免PostgreSQL连接超时
)

# 创建会话工厂
SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine
)

# 基础模型类，所有模型都继承此类
Base = declarative_base()
