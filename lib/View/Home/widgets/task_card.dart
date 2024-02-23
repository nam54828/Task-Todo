import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_todo/Controller/home_controller.dart';
import 'package:task_todo/Model/task_model.dart';
import 'package:task_todo/utils/extensions.dart';

import 'add_dialog.dart';


class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final TaskModel taskModel;

  TaskCard({Key? key, required this.taskModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(taskModel.color);
    return GestureDetector(
      onTap: (){
        Get.to(AddDialog());
      },
      child: Container(
        width: 200,
        height: 200,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[600]!,
              blurRadius: 10,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: 100,
              currentStep: 80,
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [color.withOpacity(0.5), color]),
              unselectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [Colors.white, Colors.white]),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                IconData(taskModel.icon, fontFamily: 'MaterialIcons'),
                color: color,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text('${taskModel.todos?.length ?? 0} Task' ,style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                  ),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
