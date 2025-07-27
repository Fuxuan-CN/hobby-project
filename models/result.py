
from __future__ import annotations
from typing import TypeVar, Generic

T = TypeVar('T')

class Result(Generic[T]):
    """ 返回的结果 """

    def __init__(self,
        code: int,
        msg: str,
        data: T
    ) -> None:
        self.code = code
        self.msg = msg
        self.data = data

    @staticmethod
    def success(data: T = None) -> Result:
        return Result(200, "ok", data) 
    
    @staticmethod
    def failed() -> Result:
        return Result(500, "please wait again", None)
    
    @staticmethod
    def unauthorized() -> Result:
        return Result(401, "unauthorized", None)