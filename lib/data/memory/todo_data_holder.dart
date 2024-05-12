import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'todo_status.dart';
import 'vo_todo.dart';

final userProvider = FutureProvider<String>((ref) => 'abc');

// 전역 변수로 설정되어 있어도 ProviderScope에 따라 데이터 공간 분리
// 선언한 거라 생각하면 됨
final todoDataProvider = StateNotifierProvider<TodoDataHolder, List<Todo>>((ref) {
  // refresh(userProvider); > 실행 이후 watch가 동작하게 됨, 새로운 userId 가져옴
  final userId = ref.watch(userProvider);
  debugPrint(userId.value!);
  // 새로운 userId에 해당하는 DataHolder를 새로 세팅 가능
  return TodoDataHolder();
});

class TodoDataHolder extends StateNotifier<List<Todo>> {
  // 초기 구성은 비어있는 List로 시작
  TodoDataHolder() : super([]);

  void changeTodoStatus(Todo todo) async {
    switch (todo.status) {
      case TodoStatus.incomplete:
        todo.status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        todo.status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog('정말로 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          todo.status = TodoStatus.incomplete;
        });
    }

    state = List.of(state);
  }

  // method 안에서는 await 이후 보장됨
  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      state.add(
        Todo(
          id: DateTime.now().millisecondsSinceEpoch,
          title: result.text,
          dueDate: result.dateTime,
        ),
      );
      state = List.of(state);
    }
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;
      state = List.of(state);
    }
  }

  void removeTodo(Todo todo) {
    state.remove(todo);
    state = List.of(state);
  }
}

extension TodoListHolderProvider on WidgetRef {
  TodoDataHolder get readTodoHolder => read(todoDataProvider.notifier);
}