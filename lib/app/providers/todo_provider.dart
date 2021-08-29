import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todolist/app/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  int get todosCount {
    return _todos.length;
  }

  void saveTodo(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final todo = Todo(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['title'] as String,
      description: data['description'] as String,
    );
    if (hasId) {
      updateTodo(todo);
    } else {
      addTodo(todo);
    }
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    int index = _todos.indexWhere((element) => element.id == todo.id);

    if (index >= 0) {
      _todos[index] = todo;
      notifyListeners();
    }
  }

  void deleteTodo(Todo todo) {
    int index = _todos.indexWhere((element) => element.id == todo.id);

    if (index >= 0) {
      _todos.removeWhere((element) => element.id == todo.id);
      notifyListeners();
    }
  }

  void toggleDone(String id) {
    var index = _todos.indexWhere((element) => element.id == id);
    _todos[index].isDone = !_todos[index].isDone;
    notifyListeners();
  }
}
