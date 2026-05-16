import os
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    db_user: str
    db_pass: str
    db_name: str
    db_host: str

    class Config:
        ROOT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
        env_file = f"{ROOT_DIR}/.env"


settings = Settings()
