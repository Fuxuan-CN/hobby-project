
from models.result import Result
from models.user import UserBase

class UserService:
    """ 用户服务 """

    @staticmethod
    async def login_with_username(username: str, password: str) -> Result[str]:
        """ 用 username 方法登录 """
        return Result.success(f"username: {username}, password: {password}")

    @staticmethod
    async def login_with_phone(phone: str, password: str) -> Result[str]:
        """ 用 phone 方法登录 """
        return Result.success(f"phone: {phone}, password: {password}")

    @staticmethod
    async def login_with_email(email: str, password: str) -> Result[str]:
        """ 用 email 方法登录 """
        return Result.success(f"email: {email}, password: {password}")
    
    @staticmethod
    async def get_user_info(user_id: int) -> Result[UserBase]:
        """ 获取用户信息 """
        ...

    @staticmethod
    async def update_user_info(user_id: str, user_data: UserBase) -> Result[None]:
        """ 设置用户信息 """
        ...