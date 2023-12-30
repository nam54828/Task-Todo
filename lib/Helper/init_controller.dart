import 'package:get/get.dart';
import 'package:task_todo/Controller/home_controller.dart';

Future<void> InitController() async {
  Get.lazyPut(() => HomeController());
}