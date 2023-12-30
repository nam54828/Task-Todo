import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_todo/Components/icons.dart';

import 'package:task_todo/Model/dotted_models.dart';

import '../../../Controller/home_controller.dart';

class AddCart extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddCart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Icon> iconList = icons();
    return Container(
      margin: EdgeInsets.all(3),
      child: InkWell(
        onTap: ()async{
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 20),
            radius: 5,
            title: "Task Type",
            content: Form(
                key: homeCtrl.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: homeCtrl.editingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title'
                        ),
                        validator: (value){
                          if(value == null || value.trim().isEmpty){
                            return 'Please enter your task title';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 6,
                      children: iconList.map((icon) {
                        final index = iconList.indexOf(icon);
                        return Obx(() => FilterChip(
                          label: icon,
                          side: BorderSide.none,
                          selected: homeCtrl.chipIndex.value == index,
                          onSelected: (bool selected) {
                            homeCtrl.chipIndex.value = selected ? index : 0;
                          },
                          // showCheckmark: false, // dau tich
                          checkmarkColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(12),
                          ),
                        ));
                      }).toList(),
                    ),
                  ],
            ))
          );
        },
        child: CustomPaint(
          painter: Dotted(),
          child: Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            child: Icon(Icons.add,color: Colors.white, size: 50),
          ),
        ),
      ),
    );
  }
}
