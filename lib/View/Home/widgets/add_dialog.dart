
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_todo/utils/extensions.dart';

import '../../../Controller/home_controller.dart';
import '../../../Model/task_model.dart';
import 'icons.dart';
class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            homeCtrl.editingController.clear();
            homeCtrl.changeTask(null);
          },
          icon: Icon(CupertinoIcons.xmark),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStatePropertyAll(Colors.transparent),
            ),
            onPressed: () {
              // _saveTask(context);
              if(homeCtrl.formKey.currentState!.validate()){
                if(homeCtrl.task.value == null){
                  SnackBar(
                    content: Text('Please select task'),
                  );
                } else {
                  var success = homeCtrl.updateTask(
                    homeCtrl.task.value!,
                    homeCtrl.editingController.text
                  );
                  if(success){
                    SnackBar(
                      content: Text("Todo item add success"),
                    );
                    Get.back();
                    homeCtrl.changeTask(null);
                  } else {
                    SnackBar(content: Text("Todo item already exists"));
                  }
                  homeCtrl.editingController.clear();
                }
              }
            },
            child: Text(
              "DONE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: Form(
        key: homeCtrl.formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Text(
                "New Task",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: homeCtrl.editingController,
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your task!';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Add symbol",
                style: TextStyle(color: Colors.grey),
              ),
              // Wrap(
              //   spacing: 6,
              //   children: getIcons().map((icon) {
              //     final index = getIcons().indexOf(icon);
              //     return GestureDetector(
              //       onTap: () {
              //         homeCtrl.chipIndex.value = index;
              //       },
              //       child: Obx(
              //             () => FilterChip(
              //           label: Icon(icon.icon),
              //           backgroundColor: homeCtrl.chipIndex.value == index ? Colors.blue : null,
              //           onSelected: (bool selected) {
              //             homeCtrl.chipIndex.value = selected ? index : -1;
              //           },
              //         ),
              //       ),
              //     );
              //   }).toList(),
              // ),
              ...homeCtrl.tasks.map((element) => Obx(
          ()=> InkWell(
                  onTap: () => homeCtrl.changeTask(element),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(IconData(element.icon,fontFamily: 'MaterialIcons'),
                              color: HexColor.fromHex(element.color),),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              element.title,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        if(homeCtrl.task.value == element)
                          const Icon(Icons.check, color: Colors.blue,)
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  void _saveTask(BuildContext context) {
    final icons = getIcons();
    if (homeCtrl.formKey.currentState!.validate()) {
      int icon = icons[homeCtrl.chipIndex.value].icon!.codePoint;
      String color = icons[homeCtrl.chipIndex.value].color!.toHex();
      final task = TaskModel(
        title: homeCtrl.editingController.text,
        icon: icon,
        color: color
      );
      final success = homeCtrl.addTask(task);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? "Success Add Task" : "Task Already Exists"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
