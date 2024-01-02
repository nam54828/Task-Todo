import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TaskModel extends Equatable {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todos;

  const TaskModel(
      {required this.title,
        required this.icon,
        required this.color,
        this.todos});

  TaskModel copyWith(
      {String? title, int? icon, String? color, List<dynamic>? todos}) =>
      TaskModel(
          title: title ?? this.title,
          icon: icon ?? this.icon,
          color: color ?? this.color,
          todos: todos ?? this.todos);

  factory TaskModel.fromJson(Map<dynamic, dynamic> json) => TaskModel(
      title: json['title'],
      icon: json['icon'],
      color: json['color'],
      todos: json['todos']);

  Map<String, dynamic> toJson() =>
      {'title': title, 'icon': icon, 'color': color, 'todos': todos};

  @override
  List<Object?> get props => [title, icon, color];
}
