import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
import 'package:flutter/cupertino.dart';

import 'todo_data_notifier.dart';
import 'todo_status.dart';
import 'vo_todo.dart';

// InheritedWidget을 상속받은 것이기에 위젯 트리 구조를 잘 봐야한다.
// holder를 선언한 위젯의 상위 위젯에 대해서는 해당 notifier에 접근 불가
class TodoDataHolder extends InheritedWidget {
  final TodoDataNotifier notifier;

  const TodoDataHolder({
    super.key,
    required super.child,
    required this.notifier,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static TodoDataHolder _of(BuildContext context) {
    // 같은 위젯 트리안에 있는 어느 위젯에서 TodoDataHolder를 반환해준다.
    TodoDataHolder inherited = context.dependOnInheritedWidgetOfExactType<TodoDataHolder>()!;
    return inherited;
  }

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

    notifier.notify();
  }

  // method 안에서는 await 이후 보장됨
  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      // await 이후에 화면이 꺼져버리거나 context가 유효하지 않은 상태일 수 있다.
      // mounted 상태 체크를 통해 아래 내용이 유효한지 먼저 체크할 수 있다.
      // (mounted: 현재 화면이 살아있는지 체크할 수 있는 Getter)
      notifier.addTodo(
        Todo(
            id: DateTime.now().millisecondsSinceEpoch,
            title: result.text,
            dueDate: result.dateTime),
      );
    }
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;
      notifier.notify();
    }
  }

  void removeTodo(Todo todo) {
    notifier.value.remove(todo);
    notifier.notify();
  }
}

extension TodoDataHolderContextExtension on BuildContext {
  TodoDataHolder get holder => TodoDataHolder._of(this);
}
