import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
import 'package:get/get.dart';

import 'todo_status.dart';
import 'vo_todo.dart';

// InheritedWidget을 상속받은 것이기에 위젯 트리 구조를 잘 봐야한다.
// holder를 선언한 위젯의 상위 위젯에 대해서는 해당 notifier에 접근 불가
class TodoDataHolder extends GetxController {
  final RxList<Todo> todoList = <Todo>[].obs;

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

    // Rx를 관찰하고 있는 Obs 위젯 내부에서 빌드가 다시 일어난다.
    todoList.refresh();
  }

  // method 안에서는 await 이후 보장됨
  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      todoList.add(
        Todo(
          id: DateTime.now().millisecondsSinceEpoch,
          title: result.text,
          dueDate: result.dateTime,
        ),
      );
    }
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;
      todoList.refresh();
    }
  }

  void removeTodo(Todo todo) {
    todoList.remove(todo);
    todoList.refresh();
  }
}

mixin class TodoDataProvider {
  late final TodoDataHolder todoData = Get.find();
}
