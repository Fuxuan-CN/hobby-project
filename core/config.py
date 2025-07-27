from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    # postgresql数据库配置
    DB_HOST: str = "127.0.0.1"
    DB_PORT: int = 5432
    DB_USER: str = ""
    DB_PASSWORD: str = ""
    DB_NAME: str = "hobby"

    # redis配置
    REDIS_HOST: str = "127.0.0.1"
    REDIS_PORT: int = 6379
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
