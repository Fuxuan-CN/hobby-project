""" 用户控制器 """
from typing import Literal
from fastapi import APIRouter

user_router = APIRouter(prefix="/user", tags=["用户模块"])

@user_router.post("/login")
async def login(account: str, login_type: Literal['username', 'email', 'phone'], password: str) -> str:
    """ 登录 """
    match login_type:
        case "username":
            return "username login method"
        case "email":
            return "email login method"
        case "phone":
            return "phone method"
        case _:
            raise Exception("unknown login method")