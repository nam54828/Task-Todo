
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Model/task_model.dart';

class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController editingController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final tasks = <TaskModel>[].obs;

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

}