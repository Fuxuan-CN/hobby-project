""" 用户控制器 """
from typing import Literal
from fastapi import APIRouter
from fastapi import HTTPException
from services.user_service import UserService

user_router = APIRouter(prefix="/user", tags=["用户模块"])

@user_router.post("/login")
async def login(login_type: Literal['username', 'email', 'phone'], account: str, password: str) -> str:
    """ 登录 """
    match login_type:
        case "username":
            return await UserService.login_with_username(account, password)
        case "email":
            return await UserService.login_with_email(account, password)
        case "phone":
            return await UserService.login_with_phone(account, password)
        case _:
            raise HTTPException(400, "unknown login method")