
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController editingController = TextEditingController();
  final chipIndex = 0.obs;

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }
}