from fastapi import FastAPI, Depends
from app.models.schemas import Todo, TodoCreate
from app.database_services.database import Base
from app.database_services.database import engine
from app.database_services.database import SessionLocal
from app.database_services.services import get_todos, get_todo_by_id, create_todo, update_todo, delete_todo
from fastapi.middleware.cors import CORSMiddleware


Base.metadata.create_all(
    bind=engine
)

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@app.get("/todos/{skip}/{limit}")
async def get_todos_list(skip: int = 0, limit: int = 100, session=Depends(get_db)):
    todos = get_todos(skip=skip, limit=limit, db=session)
    return todos


@app.get("/todo/{todo_id}")
async def get_todo(todo_id: int, session=Depends(get_db)):
    todo = get_todo_by_id(todo_id=todo_id, db=session)
    if todo:
        return todo
    return {"message": "Todo not found"}


@app.delete("/todo/{todo_id}")
async def delete_todo_by_id(todo_id: int, session=Depends(get_db)):
    todo = delete_todo(todo_id=todo_id, db=session)
    if todo:
        return {"message": f"Deleted todo with id {todo_id}"}
    return {"message": "Todo not found"}


@app.post("/todo")
async def create(request: TodoCreate, session=Depends(get_db)):
    todo = create_todo(todo=request, db=session)
    return todo


@app.put("/todo/{todo_id}")
async def update_todo_by_id(request: TodoCreate, todo_id: int, session=Depends(get_db)):
    todo = update_todo(todo_id=todo_id, todo=request, db=session)
    if todo:
        return todo
    return {"message": "Todo not found"}
