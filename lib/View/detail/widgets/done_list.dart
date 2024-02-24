import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_todo/Controller/home_controller.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doneTodos.isNotEmpty ? ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Text("Completed(${homeCtrl.doneTodos.length})",style: TextStyle(
          fontSize: 16,
          color: Colors.grey
        ),),
        ...homeCtrl.doneTodos.map((element) => Dismissible(
          key: ObjectKey(element),
          direction: DismissDirection.endToStart,
          onDismissed: (context) => homeCtrl.deleteDoneTodo(element),
          background: Container(
            color: Colors.red.withOpacity(0.8),
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete, color: Colors.white,),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                SizedBox(width: 50, height: 20,
                child: Icon(Icons.done),),
                Text(element['title'],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  decoration: TextDecoration.lineThrough
                ),)
              ],
            ),
          ),
        )).toList()
      ],
    ) : Container());
  }
}
