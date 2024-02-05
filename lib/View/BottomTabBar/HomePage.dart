import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_todo/Controller/home_controller.dart';
import 'package:task_todo/Model/task_model.dart';
import 'package:task_todo/View/Home/page/crud_list.dart';
import 'package:task_todo/View/Home/page/home.dart';
import 'package:task_todo/View/Home/page/profile.dart';
import 'package:task_todo/View/Home/page/setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeCtrl = Get.find<HomeController>();
  int currentTab = 0;
  final List<Widget> screens = [crud_List(), Home(), profile(), Setting()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: DragTarget<TaskModel>(
        builder: (_,__,___){
          return Obx(
                () => FloatingActionButton(
              onPressed: () {},
              child: Icon(homeCtrl.deleting.value ? Icons.delete : Icons.add, size: 32, color: Colors.white,),
              backgroundColor: homeCtrl.deleting.value ? Colors.red : Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)
              ),
            ),
          );
        },
        onAccept: (TaskModel taskModel){
          homeCtrl.deleteTask(taskModel);
          if(homeCtrl.deleteTask(taskModel) == true){
            showDialog(context: context, builder: (_){
              return AlertDialog(
                title: Icon(Icons.done),
                content: Text("Delete Success"),
              );
            });
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(28, 28, 29, 1),
        height: 70,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = Home();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: currentTab == 0 ? Colors.blue : Colors.grey,
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = crud_List();
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list_alt,
                      color: currentTab == 1 ? Colors.blue : Colors.grey,
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = profile();
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: currentTab == 2 ? Colors.blue : Colors.grey,
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = Setting();
                    currentTab = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings,
                      color: currentTab == 3 ? Colors.blue : Colors.grey,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
