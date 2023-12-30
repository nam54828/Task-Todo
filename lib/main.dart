import 'package:flutter/material.dart';
import 'package:task_todo/View/Register/register.dart';
import 'package:task_todo/Helper/init_controller.dart' as di;
import 'package:get/get.dart';
Future<void> main() async{
  await di.InitController();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: register(),
    );
  }
}
