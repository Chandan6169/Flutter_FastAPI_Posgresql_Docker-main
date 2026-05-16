import 'dart:convert';

import 'package:http/http.dart';
import 'package:todo_web/todo/domain/todo.dart';

class TodoRemoteService {
  final Client _client;
  final String _baseUrl;

  TodoRemoteService(this._baseUrl) : _client = Client();

  Future<List<Todo>> getTodos() async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/todos/0/100'), headers: {
      'Access-Control-Allow-Origin': '*',
    });
    print(response.body);
    // response map
    final json = jsonDecode(response.body) as List<dynamic>;

    final todoList = json.map((e) => Todo.fromJson(e)).toList();
    return todoList;
  }

  Future<Todo> getTodoById(String id) async {
    final response = await _client.get(Uri.parse('$_baseUrl/todo/$id'));
    print(response.body);
    // response map
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    final todo = Todo.fromJson(json);
    return todo;
  }

  Future<Todo> create(String name, String description, int priority) async {
    print('in create');

    final response = await _client.post(
      Uri.parse('$_baseUrl/todo'),
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'description': description,
        'priority': priority.toString()
      }),
    );
    print(response.body);
    // response map
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return Todo.fromJson(json);
  }

  Future<Todo> update(
      int id, String name, String description, int priority) async {
    final response = await _client.put(
      Uri.parse('$_baseUrl/todo/$id'),
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'description': description,
        'priority': priority.toString()
      }),
    );
    print(response.body);
    // response map
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return Todo.fromJson(json);
  }

  Future<void> delete(int id) async {
    final response = await _client.delete(Uri.parse('$_baseUrl/todo/$id'));
    print(response.body);
  }
}
