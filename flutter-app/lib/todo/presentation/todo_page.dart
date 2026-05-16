import 'package:flutter/material.dart';
import 'package:todo_web/todo/domain/todo.dart';
import 'package:todo_web/todo/infrastructure/remote_service.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key, required this.todoRemoteService});
  final TodoRemoteService todoRemoteService;
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> _todoList = [];

  Future<void> _getTodos() async {
    final todoList = await widget.todoRemoteService.getTodos();
    setState(() {
      _todoList = todoList;
    });
  }

  Future<void> _getTodoById(String id) async {
    final todo = await widget.todoRemoteService.getTodoById(id);
    setState(() {
      _todoList.add(todo);
    });
  }

  Future<void> _create(String name, String description, int priority) async {
    final todo = await widget.todoRemoteService.create(
      name,
      description,
      priority,
    );
    setState(() {
      _todoList.add(todo);
    });
  }

  Future<void> _update(
      int id, String name, String description, int priority) async {
    final todo = await widget.todoRemoteService.update(
      id,
      name,
      description,
      priority,
    );
    setState(() {
      _todoList.add(todo);
    });
  }

  Future<void> _delete(int id) async {
    await widget.todoRemoteService.delete(id);
    setState(() {
      _todoList.removeWhere((element) => element.id == id);
    });
  }

  @override
  void initState() {
    _getTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Todos By Alankrit'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            String title = '';
            String description = '';
            int priority = 0;
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Add Todo'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      onChanged: (value) => title = value,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      onChanged: (value) => description = value,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Priority',
                      ),
                      onChanged: (value) => priority = int.parse(value),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () async {
                        await _create(title, description, priority);
                        await _getTodos();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Save')),
                ],
              ),
            );
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text('total todos: ${_todoList.length}',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () async {
                      await _getTodos();
                    },
                    child: const Text('Refresh'),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _todoList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.amberAccent,
                        child: ListTile(
                          hoverColor: Colors.blue,
                          onTap: () {
                            String name = _todoList[index].name;
                            String description = _todoList[index].description;
                            int priority = _todoList[index].priority;
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Update Todo'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration: const InputDecoration(
                                        labelText: 'Title',
                                      ),
                                      onChanged: (value) => name = value,
                                    ),
                                    TextField(
                                      decoration: const InputDecoration(
                                        labelText: 'Description',
                                      ),
                                      onChanged: (value) => description = value,
                                    ),
                                    TextField(
                                      decoration: const InputDecoration(
                                        labelText: 'Priority',
                                      ),
                                      onChanged: (value) =>
                                          priority = int.parse(value),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel')),
                                  TextButton(
                                      onPressed: () async {
                                        await _update(_todoList[index].id, name,
                                            description, priority);
                                        await _getTodos();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Save')),
                                ],
                              ),
                            );
                          },
                          title: Text(_todoList[index].name),
                          subtitle: Text(_todoList[index].description),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _delete(_todoList[index].id);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
