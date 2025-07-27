from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    # postgresql数据库配置
    DB_HOST: str = "127.0.0.1"
    DB_PORT: int = 5432
    DB_USER: str = ""
    DB_PASSWORD: str = ""
    DB_NAME: str = "hobby"

    # sqlalchemy 配置
    SQLALCHEMY_LOG: bool = True # 生产环境设为False，避免打印SQL日志
    POOL_PRE_PING: bool = True # 连接前检查连接有效性
    POOL_RECYCLE: int = 300 # 连接5分钟后自动回收，避免PostgreSQL连接超时

    # redis配置
    REDIS_HOST: str = "127.0.0.1"
    REDIS_PORT: int = 6379
    REDIS_DB: int = 0
    REDIS_PASSWORD: str = ""
    # rocketmq配置
    ROCKETMQ_GROUP: str = "hobby_group"
    ROCKETMQ_NAMESRV_ADDR: str = "127.0.0.1"
    ROCKETMQ_PORT: int = 9876
    ROCKETMQ_PASSWORD: str = ""

    @property
    def DATABASE_URL(self) -> str:
        return f"postgresql://{self.DB_USER}:{self.DB_PASSWORD}@{self.DB_HOST}:{self.DB_PORT}/{self.DB_NAME}"

    class Config:
        env_file = ".env"  # 支持从.env文件加载配置
        env_file_encoding = 'utf-8'


settings = Settings()
