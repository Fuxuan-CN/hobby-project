from datetime import datetime, date
from typing import Optional
from pydantic import BaseModel, Field

class UserInfoBase(BaseModel):
    user_info_id: int
    user_id: str = Field(..., max_length=32)
    age: Optional[int] = None
    gender: Optional[str] = Field(None, max_length=8)
    avatar_url: Optional[str] = Field(None, max_length=256)
    birthday: Optional[date] = None
    region: Optional[str] = Field(None, max_length=128)
    bio: Optional[str] = None
    is_deleted: bool = False
    created_at: datetime
    updated_at: datetime