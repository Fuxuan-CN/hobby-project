from datetime import datetime
from typing import Optional
from pydantic import BaseModel, EmailStr, Field

class UserBase(BaseModel):
    user_id: str = Field(..., max_length=32)
    username: str = Field(..., max_length=64)
    password: str = Field(..., max_length=128)
    nickname: Optional[str] = Field(None, max_length=64)
    email: EmailStr = Field(..., max_length=128)
    phone: Optional[str] = Field(None, max_length=32)
    last_login_at: datetime
    is_active: bool = True
    is_deleted: bool = False
    created_at: datetime
    updated_at: datetime
    