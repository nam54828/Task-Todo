
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Model/task_model.dart';

class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController editingController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final tasks = <TaskModel>[].obs;
  final task = Rx<TaskModel?>(null);

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  bool addTask(TaskModel taskModel) {
    if (tasks.contains(taskModel)){
      return false;
    }
    tasks.add(taskModel);
    return true;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    editingController.dispose();
    super.onClose();
  }

  void changeDeleting(bool value){
    deleting.value = value;
  }

  deleteTask(TaskModel taskModel){
    tasks.remove(taskModel);
  }

  void changeTask(TaskModel? select){
    task.value = select;
  }

  updateTask(TaskModel taskModel, String title) {
    var todos = taskModel.todos ?? [];
    if(containerTodo(todos,title)) {
    return false;
    }
    var todo = {'title':title, 'done': false};
    todos.add(todo);
    var newTask = taskModel.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(taskModel);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containerTodo(List todos,String title) {
    return todos.any((element) => element['title'] == title);
  }
}