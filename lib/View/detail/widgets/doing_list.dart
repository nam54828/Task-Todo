import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_todo/Controller/home_controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty 
    ? Column(
      children: [
        Image.asset('images/task_list.png',
        fit: BoxFit.cover,),
        Text('Add Task',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24
        ),)
      ],
    ): ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        ...homeCtrl.doingTodos.map((element) => Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  fillColor: MaterialStateProperty.resolveWith((states) => Colors.grey),
                  value: element['done'],
                  onChanged: (value){
                    homeCtrl.doneTodo(element['title']);
                  },
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(element['title'],overflow: TextOverflow.ellipsis,)
            ],
          ),
        )).toList(),
        if(homeCtrl.doingTodos.isNotEmpty)
          Padding(padding: EdgeInsets.all(12),
          child: const Divider(thickness: 2,),)
      ],
    )
    
    );
  }
}
