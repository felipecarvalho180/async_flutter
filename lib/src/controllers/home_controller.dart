import 'package:async_dart/src/models/todo_model.dart';
import 'package:async_dart/src/repositories/todo_repository.dart';
import 'package:flutter/foundation.dart';

class HomeController {
  List<TodoModel> todos = [];
  TodoRepository _repository;
  final state = ValueNotifier<HomeState>(HomeState.start);

  HomeController([TodoRepository repository]) {
    _repository = repository ?? TodoRepository();
  }

  Future start() async {
    state.value = HomeState.loading;
    try {
      todos = await _repository.fetchTodos();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
