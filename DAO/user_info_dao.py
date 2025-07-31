""" 用户信息数据访问 """

from db import Base
from sqlalchemy import Column, Integer, String, Boolean, DateTime, Date, Text
from sqlalchemy.sql import func

class UserInfoDAO(Base):
    __tablename__ = 'user_info'
    
    user_info_id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(String(32), nullable=False)
    age = Column(Integer)
    gender = Column(String(8))
    avatar_url = Column(String(256))
    birthday = Column(Date)
    region = Column(String(128))
    bio = Column(Text)
    is_deleted = Column(Boolean, default=False)
    created_at = Column(DateTime, nullable=False, default=func.now())
    updated_at = Column(DateTime, nullable=False, default=func.now(), onupdate=func.now())