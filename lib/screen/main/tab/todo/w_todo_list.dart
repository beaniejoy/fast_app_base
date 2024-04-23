import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      // notifier 안에 있는 value 값이 그대로 builder로 들어간다라고 생각하면 된다.
      valueListenable: context.holder.notifier,
      builder: (context, todoList, child) {
        return todoList.isEmpty
            ? '할일을 작성해보세요'.text.size(30).makeCentered()
            : Column(
                children: todoList.map((e) => TodoItem(e)).toList(),
              );
      },
    );
  }
}
