from app.database_services.database import Base
from sqlalchemy import Column, Integer, String, Enum as SQLEnum, ForeignKey


class Todo(Base):
    __tablename__ = "todos"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    description = Column(String)
    priority = Column(Integer)
