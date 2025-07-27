
from models.result import Result

class UserService:
    """ 用户服务 """

    @staticmethod
    async def login_with_username(username: str, password: str) -> Result[str]:
        """ 用 username 方法登录 """
        return Result.success(f"username: {username}, password: {password}")

    @staticmethod
    async def login_with_phone(phone: str, password: str) -> Result[str]:
        """ 用 phone 方法登录 """
        return Result.success(f"phone: {phone}, password: {phone}")

    @staticmethod
    async def login_with_email(email: str, password: str) -> Result[str]:
        """ 用 email 方法登录 """
        return Result.success(f"email: {email}, password: {password}")