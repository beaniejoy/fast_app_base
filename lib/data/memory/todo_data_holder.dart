import 'package:fast_app_base/data/memory/bloc/bloc_status.dart';
import 'package:fast_app_base/data/memory/bloc/todo_bloc_state.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'todo_status.dart';
import 'vo_todo.dart';

// InheritedWidget을 상속받은 것이기에 위젯 트리 구조를 잘 봐야한다.
// holder를 선언한 위젯의 상위 위젯에 대해서는 해당 notifier에 접근 불가
class TodoCubit extends Cubit<TodoBlocState> {
  TodoCubit() : super(const TodoBlocState(BlocStatus.initial, <Todo>[]));

  // method 안에서는 await 이후 보장됨
  void addTodo() async {
    final result = await WriteTodoDialog().show();

    if (result != null) {
      final copiedOldTodoList = List.of(state.todoList);
      copiedOldTodoList.add(
        Todo(
          id: DateTime.now().millisecondsSinceEpoch,
          title: result.text,
          dueDate: result.dateTime,
          createdTime: DateTime.now(),
          status: TodoStatus.incomplete,
        ),
      );

      emitNewList(copiedOldTodoList);
    }
  }

  void changeTodoStatus(Todo todo) async {
    final copiedOldTodoList = List.of(state.todoList);
    final todoIndex = copiedOldTodoList.indexWhere((element) => element.id == todo.id);

    TodoStatus status = todo.status;
    switch (todo.status) {
      case TodoStatus.incomplete:
        status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog('정말로 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          status = TodoStatus.incomplete;
        });
    }

    copiedOldTodoList[todoIndex] = todo.copyWith(status: status);
    emitNewList(copiedOldTodoList);
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      final copiedOldTodoList = List.of(state.todoList);
      final todoIndex = copiedOldTodoList.indexWhere((element) => element.id == todo.id);

      copiedOldTodoList[todoIndex] = todo.copyWith(
        title: result.text,
        dueDate: result.dateTime,
        modifyTime: DateTime.now(),
      );
      emitNewList(copiedOldTodoList);
    }
  }

  void removeTodo(Todo todo) {
    final copiedOldTodoList = List.of(state.todoList);
    copiedOldTodoList.removeWhere((element) => element.id == todo.id);
    emitNewList(copiedOldTodoList);
  }

  // 귀찮긴 한데 bloc을 사용하면 추적이 편리하고 견고한 애플리케이션 개발 가능
  void emitNewList(List<Todo> copiedOldTodoList) {
    emit(state.copyWith(todoList: copiedOldTodoList));
  }
}
