
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../Model/task_model.dart';

class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController editingController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final tasks = <TaskModel>[].obs;
  final task = Rx<TaskModel?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

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

  void changTodos(List<dynamic> select){
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i< select.length; i++){
      var todo = select[i];
      var status = todo['done'];
      if(status == true) {
        doneTodos.add(todo);
      }else{
        doingTodos.add(todo);
      }
    }
  }

  bool addTodo(String title) {
    var todo = {'title' : title, 'done':false};
    if (doingTodos.any((element) => mapEquals<String, dynamic>(todo, element))){
      return false;
    }
    var doneTodo = {'title': title, 'done': true};
    if (doneTodos.any((element) => mapEquals<String,dynamic>(doneTodo, element))){
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([
      ...doingTodos,
    ...doneTodos,
    ]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIdx = tasks.indexOf(task.value);
    tasks[oldIdx] = newTask;
    tasks.refresh();
  }
  void doneTodo(String title){
    var doingTodo = {'title': title, 'done': false};
    int index = doingTodos.indexWhere((element) => mapEquals<String , dynamic>(doingTodo,element));
    doingTodos.removeAt(index);
    var doneTodo = {'title': title, 'done': true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }

  void deleteDoneTodo(dynamic doneTodo) {
    int index = doneTodos.indexWhere((element) => mapEquals<String,dynamic>(doneTodo,element));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodosEmpty(TaskModel taskModel){
    return taskModel.todos == null || taskModel.todos!.isEmpty;
  }

  int getDoneTodo(TaskModel taskModel) {
    var res = 0;
    for(int i = 0; i < taskModel.todos!.length; i++){
      if(taskModel.todos![i]['done'] == true){
        res += 1;
      }
    }
    return res;
  }
}