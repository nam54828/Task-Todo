import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_todo/Controller/home_controller.dart';
import 'package:task_todo/View/detail/widgets/doing_list.dart';
import 'package:task_todo/View/detail/widgets/done_list.dart';
import 'package:task_todo/utils/extensions.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
          homeCtrl.updateTodos();
          homeCtrl.changeTask(null);
          homeCtrl.editingController.clear();
        },
            icon: Icon(CupertinoIcons.back)),
      ),
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.all(12),
            child: Row(
              children: [
                  Icon(IconData(
                    task.icon,
                    fontFamily: 'MaterialIcons'
                  ),
                  color: color,
                  ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),),
            Obx(() {
              var totalTodos = homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
              return Padding(
                padding: const EdgeInsets.only(top: 5, left: 50, right: 50),
                child: Row(
                  children: [
                    Text('$totalTodos Tasks', style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                    ),),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                      currentStep: homeCtrl.doneTodos.length,
                      size: 5,
                      padding: 0,
                      selectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end:  Alignment.bottomRight,
                        colors: [color.withOpacity(0.5), color]
                      ),
                      unselectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end:  Alignment.bottomRight,
                          colors: [Colors.grey[300]!,Colors.grey[300]!]
                      ),
                    ))
                  ],
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                controller: homeCtrl.editingController,
                autofocus: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!)
                  ),
                  prefixIcon: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey[400],
                  ),
                  suffixIcon: IconButton(onPressed: (){
                    var success = homeCtrl.addTodo(
                      homeCtrl.editingController.text
                    );
                    if(success){
                      Get.defaultDialog(
                        title: 'Todo item add success'
                      );
                    } else {
                      Get.defaultDialog(
                        title: 'Todo item already exists'
                      );
                    }
                    homeCtrl.editingController.clear();
                  }, icon: Icon(Icons.done))
                ),
                validator: (value){
                  if (value == null || value.trim().isEmpty){
                    return 'Please enter your todo item';
                  }
                },
              ),
            ),
            DoingList(),
            DoneList()
          ],
        ),
      ),
    );
  }
}
