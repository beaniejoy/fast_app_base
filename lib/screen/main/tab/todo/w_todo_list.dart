import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// GetView로 보다 간편하게 등록 가능 하지만 사용하지 않는다. (여러 개 데이터를 관리해야할 때 등으로)
class TodoList extends StatelessWidget with TodoDataProvider {
  TodoList({super.key});

  @override
  Widget build(BuildContext context) { 
    // GetBuilder로 사용가능(그러나 하나만 받을 수 있어서 잘 사용 X)
    return Obx(
      () => todoData.todoList.isEmpty
          ? '할일을 작성해보세요'.text.size(30).makeCentered()
          : Column(
              children: todoData.todoList.map((e) => TodoItem(e)).toList(),
            ),
    );
  }
}
