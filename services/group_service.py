
from models.result import Result


class GroupService:
    """ 群聊服务 """

    @staticmethod
    async def create_group() -> Result[None]:
        """ 创建群聊 """
        ...

    @staticmethod
    async def delete_group() -> Result[None]:
        """ 解散群聊 """
        ...

    @staticmethod
    async def get_group_member(group_id: int) -> Result[list]:
        """ 获取群成员 """
        ...

    @staticmethod
    async def add_user_to_group(group_id: int, user_id: int) -> Result[None]:
        """ 添加用户到群 """
        ...

    @staticmethod
    async def remove_user_from_group(group_id: int, user_id: int) -> Result[None]:
        """ 从群中移除用户 """
        ...
    