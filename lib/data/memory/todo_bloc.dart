import 'package:fast_app_base/data/memory/bloc/bloc_status.dart';
import 'package:fast_app_base/data/memory/bloc/todo_bloc_state.dart';
import 'package:fast_app_base/data/memory/bloc/todo_event.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/write/d_write_todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'todo_status.dart';
import 'vo_todo.dart';

// InheritedWidget을 상속받은 것이기에 위젯 트리 구조를 잘 봐야한다.
// holder를 선언한 위젯의 상위 위젯에 대해서는 해당 notifier에 접근 불가
class TodoBloc extends Bloc<TodoEvent, TodoBlocState> {
  TodoBloc() : super(const TodoBlocState(BlocStatus.initial, <Todo>[])) {
    on<TodoAddEvent>(_addTodo); // 여기서 transformer 적용 가능
    on<TodoStatusUpdateEvent>(_changeTodoStatus);
    on<TodoContentUpdateEvent>(_editTodo);
    on<TodoRemovedEvent>(_removeTodo);
  }

  // method 안에서는 await 이후 보장됨
  void _addTodo(TodoAddEvent event, Emitter<TodoBlocState> emit) async {
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

      emitNewList(copiedOldTodoList, emit);
    }
  }

  void _changeTodoStatus(TodoStatusUpdateEvent event, Emitter<TodoBlocState> emit) async {
    final copiedOldTodoList = List.of(state.todoList);
    final todo = event.updatedTodo;
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
    emitNewList(copiedOldTodoList, emit);
  }

  void _editTodo(TodoContentUpdateEvent event, Emitter<TodoBlocState> emit) async {
    final todo = event.updatedTodo;
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      final copiedOldTodoList = List.of(state.todoList);
      final todoIndex = copiedOldTodoList.indexWhere((element) => element.id == todo.id);

      copiedOldTodoList[todoIndex] = todo.copyWith(
        title: result.text,
        dueDate: result.dateTime,
        modifyTime: DateTime.now(),
      );
      emitNewList(copiedOldTodoList, emit);
    }
  }

  void _removeTodo(TodoRemovedEvent event, Emitter<TodoBlocState> emit) {
    final copiedOldTodoList = List.of(state.todoList);
    final todo = event.removedTodo;
    copiedOldTodoList.removeWhere((element) => element.id == todo.id);
    emitNewList(copiedOldTodoList, emit);
  }

  // 귀찮긴 한데 bloc을 사용하면 추적이 편리하고 견고한 애플리케이션 개발 가능
  void emitNewList(List<Todo> copiedOldTodoList, Emitter<TodoBlocState> emit) {
    emit(state.copyWith(todoList: copiedOldTodoList));
  }
}
