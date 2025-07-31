""" 用户数据访问 """

from db import Base
from sqlalchemy import Column, String, Boolean, DateTime
from sqlalchemy.sql import func

class UserDAO(Base):
    __tablename__ = 'users'
    
    user_id = Column(String(32), primary_key=True)
    username = Column(String(64), nullable=False, unique=True)
    password = Column(String(128), nullable=False)
    nickname = Column(String(64))
    email = Column(String(128), nullable=False, unique=True)
    phone = Column(String(32))
    last_login_at = Column(DateTime, nullable=False)
    is_active = Column(Boolean, default=True)
    is_deleted = Column(Boolean, default=False)
    created_at = Column(DateTime, nullable=False, default=func.now())
    updated_at = Column(DateTime, nullable=False, default=func.now(), onupdate=func.now())
