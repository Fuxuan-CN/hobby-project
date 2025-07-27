
from __future__ import annotations
from typing import TypeVar, Generic
from pydantic import BaseModel

T = TypeVar('T')

class Result(BaseModel, Generic[T]):
    """ 返回的结果 """
    code: int
    msg: str
    data: T

    @staticmethod
    def success(data: T = None) -> Result[T]:
        return Result(code=200, msg="ok", data=data) 
    
    @staticmethod
    def failed() -> Result[None]:
        return Result(code=500, msg="please wait again", data=None)
    
    @staticmethod
    def unauthorized() -> Result[None]:
        return Result(code=401, msg="unauthorized", data=None)