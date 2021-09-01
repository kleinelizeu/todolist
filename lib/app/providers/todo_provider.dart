import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/app/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;
  SharedPreferences sharedPreferences;

  int get todosCount {
    return _todos.length;
  }

  void saveTodo(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final todo = Todo(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['title'] as String,
      description: data['description'] as String,
      date: data['date'],
    );
    if (hasId) {
      updateTodo(todo);
    } else {
      addTodo(todo);
    }
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    saveData();
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    int index = _todos.indexWhere((element) => element.id == todo.id);

    if (index >= 0) {
      _todos[index] = todo;

      notifyListeners();
      saveData();
    }
  }

  void deleteTodo(Todo todo) {
    int index = _todos.indexWhere((element) => element.id == todo.id);

    if (index >= 0) {
      _todos.removeWhere((element) => element.id == todo.id);
      saveData();
      notifyListeners();
    }
  }

  void saveData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    List<String> spList =
        _todos.map((todo) => json.encode(todo.toMap())).toList();
    sharedPreferences.setStringList('title', spList);
    print(spList);
  }

  void loadData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    List<String> spList = sharedPreferences.getStringList('title');
    _todos = spList.map((todo) => Todo.fromMap(json.decode(todo))).toList();
    notifyListeners();
  }
}
