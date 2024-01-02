import 'package:flutter/material.dart';
import 'package:task_todo/Components/colors.dart';

import '../../../Components/icons.dart';


List<Icon> getIcons(){
  return const [
    Icon(IconData(personIcon, fontFamily: 'MaterialIcons'), color: Colors.purple,),
    Icon(IconData(workIcon, fontFamily: 'MaterialIcons'), color: Colors.pink),
    Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'), color: Colors.pink),
    Icon(IconData(sprotIcon, fontFamily: 'MaterialIcons'), color: Colors.green,),
    Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'), color: Colors.yellow),
    Icon(IconData(shopIcon, fontFamily: 'MaterialIcons'), color: Colors.lightBlue),
  ];
}