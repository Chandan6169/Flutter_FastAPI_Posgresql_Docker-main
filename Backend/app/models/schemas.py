from pydantic import BaseModel


class Todo(BaseModel):
    id: int
    name: str
    description: str
    priority: int


class TodoCreate(BaseModel):
    name: str
    description: str
    priority: int
