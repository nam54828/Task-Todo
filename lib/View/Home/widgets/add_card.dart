import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_todo/Model/dotted_models.dart';
import 'package:task_todo/Model/task_model.dart';
import 'package:task_todo/View/Home/widgets/icons.dart';
import 'package:task_todo/utils/extensions.dart';
import '../../../Controller/home_controller.dart';

class AddCart extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  AddCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    return Container(
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 20),
              radius: 5,
              title: "Task Type",
              titleStyle: TextStyle(
                fontWeight: FontWeight.w800
              ),
              content: Form(
                  key: homeCtrl.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: homeCtrl.editingController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Title'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your task title';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Wrap(
                          spacing: 6,
                          children: icons.map((icon) {
                            final index = icons.indexOf(icon);
                            return Obx(() => FilterChip(
                                  label: icon,
                                  side: BorderSide.none,
                                  selected: homeCtrl.chipIndex.value == index,
                                  onSelected: (bool selected) {
                                    homeCtrl.chipIndex.value =
                                        selected ? index : 0;
                                  },
                                  // showCheckmark: false, // dau tich
                                  checkmarkColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ));
                          }).toList(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          int icon = icons[homeCtrl.chipIndex.value].icon!.codePoint;
                          String color = icons[homeCtrl.chipIndex.value].color!.toHex();

                          if (homeCtrl.formKey.currentState!.validate()) {
                            var task = TaskModel(
                                title: homeCtrl.editingController.text,
                                icon: icon,
                                color: color)
                            ;
                            Get.back();
                           bool success =  homeCtrl.addTask(task);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(success ? "Success Add Task" : "Fail! Please try again"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                          homeCtrl.editingController.clear();
                          homeCtrl.changeChipIndex(0);
                        },
                        child: Center(
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                            minimumSize: Size(110, 40)),
                      )
                    ],
                  )));
        },
        child: CustomPaint(
          painter: Dotted(),
          child: Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            child: Icon(Icons.add, color: Colors.white, size: 50),
          ),
        ),
      ),
    );
  }
}
