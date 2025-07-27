import redis
from core.config import settings
import json
from typing import Optional, Union, List, Dict


class RedisClient:
    def __init__(self):
        self.client = redis.Redis(
            host=settings.REDIS_HOST,
            port=settings.REDIS_PORT,
            db=settings.REDIS_DB,
            decode_responses=True # 自动解码为字符串
        )

    def set(self, key: str, value: Union[str, dict, list],
            expire: Optional[int] = None) -> bool:
        """
        设置键值对

        :param key: 键
        :param value: 值（支持字符串、字典、列表）
        :param expire: 过期时间（秒），None表示永不过期
        :return: 是否成功
        """
        try:
            # 处理非字符串类型
            if isinstance(value, (dict, list)):
                value = json.dumps(value)

            result = self.client.set(key, value, ex=expire)
            return result is True
        except Exception as e:
            return False

    async def get(self, key: str, is_json: bool = False) -> Optional[Union[str, dict, list]]:
        """
        获取键值

        :param key: 键
        :param is_json: 是否需要解析为JSON
        :return: 对应的值，不存在返回None
        """
        try:
            value = await self.client.get(key)
            if value is None:
                return None
            if is_json:
                return json.loads(value)
            return value
        except Exception as e:
            return None

    async def delete(self, key: str) -> bool:
        """
        删除键

        :param key: 键
        :return: 是否成功
        """
        try:
            result = await self.client.delete(key)
            return result > 0
        except Exception as e:
            return False

    async def hset(self, name: str, key: str, value: Union[str, dict, list]) -> bool:
        """
        设置哈希表字段

        :param name: 哈希表名称
        :param key: 字段名
        :param value: 字段值
        :return: 是否成功
        """
        try:
            if isinstance(value, (dict, list)):
                value = json.dumps(value)

            result = await self.client.hset(name, key, value) # type: ignore
            return result >= 0
        except Exception as e:
            return False

    async def hget(self, name: str, key: str, is_json: bool = False) -> Optional[
        Union[str, dict, list]]:
        """
        获取哈希表字段值

        :param name: 哈希表名称
        :param key: 字段名
        :param is_json: 是否需要解析为JSON
        :return: 字段值，不存在返回None
        """
        try:
            value = await self.client.hget(name, key) # type: ignore
            if value is None:
                return None

            if is_json:
                return json.loads(value)
            return value
        except Exception as e:
            return None

    async def hgetall(self, name: str, is_json: bool = False) -> Dict[
        str, Union[str, dict, list]]:
        """
        获取哈希表所有字段和值

        :param name: 哈希表名称
        :param is_json: 是否需要解析为JSON
        :return: 包含所有字段和值的字典
        """
        try:
            items = await self.client.hgetall(name) # type: ignore
            if is_json and items:
                return {k: json.loads(v) for k, v in items.items()}
            return items
        except Exception as e:
            return {}

    async def lpush(self, name: str, *values: Union[str, dict, list]) -> int:
        """
        向列表左侧添加元素

        :param name: 列表名称
        :param values: 要添加的元素
        :return: 添加后列表的长度
        """
        try:
            processed_values = []
            for v in values:
                if isinstance(v, (dict, list)):
                    processed_values.append(json.dumps(v))
                else:
                    processed_values.append(str(v))

            return await self.client.lpush(name, *processed_values) # type: ignore
        except Exception as e:
            return 0

    async def rpop(self, name: str, is_json: bool = False) -> Optional[
        Union[str, dict, list]]:
        """
        从列表右侧弹出元素

        :param name: 列表名称
        :param is_json: 是否需要解析为JSON
        :return: 弹出的元素
        """
        try:
            value = await self.client.rpop(name) # type: ignore
            if value is None:
                return None

            if is_json:
                return json.loads(value) # type: ignore
            return value
        except Exception as e:
            return None

    async def expire(self, key: str, seconds: int) -> bool:
        """
        设置键的过期时间

        :param key: 键
        :param seconds: 过期时间（秒）
        :return: 是否成功
        """
        try:
            return await self.client.expire(key, seconds)
        except Exception as e:
            return False

    async def exists(self, key: str) -> bool:
        """
        检查键是否存在

        :param key: 键
        :return: 是否存在
        """
        try:
            return await self.client.exists(key) > 0
        except Exception as e:
            return False


# 单例实例
redis_client = RedisClient()
