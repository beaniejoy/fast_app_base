import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:flutter/cupertino.dart';

// vue에서 watch 같은 개념?
// ValueNotifier를 이용한 상태관리
@Deprecated("Getx로 전환")
class TodoDataNotifier extends ValueNotifier<List<Todo>> {
  TodoDataNotifier(): super([]);

  void addTodo(Todo todo) {
    value.add(todo);
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}