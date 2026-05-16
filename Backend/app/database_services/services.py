from sqlalchemy.orm import Session
from app.models.schemas import TodoCreate
from app.models.models import Todo as TodoModel

def get_todos(db: Session, skip: int = 0, limit: int = 100):
    return db.query(TodoModel).offset(skip).limit(limit).all()


def get_todo_by_id(db: Session, todo_id: int):
    return db.query(TodoModel).filter(TodoModel.id == todo_id).first()


def create_todo(db: Session, todo: TodoCreate):
    db_todo = TodoModel(name=todo.name, description=todo.description, priority=todo.priority)
    db.add(db_todo)
    db.commit()
    db.refresh(db_todo)
    return db_todo


def update_todo(db: Session, todo_id: int, todo: TodoCreate):
    db_todo = db.query(TodoModel).filter(TodoModel.id == todo_id).first()
    if db_todo:
        db_todo.name = todo.name
        db_todo.description = todo.description
        db_todo.priority = todo.priority
        db.commit()
        db.refresh(db_todo)
    return db_todo


def delete_todo(db: Session, todo_id: int):
    db_todo = db.query(TodoModel).filter(TodoModel.id == todo_id).first()
    if db_todo:
        db.delete(db_todo)
        db.commit()
    return db_todo
