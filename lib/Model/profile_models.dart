import 'package:flutter/material.dart';

class profileModel {
  final String icon;
  final String text;
  profileModel(this.icon, this.text);
}

final List<profileModel> profileModels = [
  profileModel('person', 'My Profile'),
  profileModel('setting', 'Settings'),
  profileModel('help', 'Help'),
  profileModel('logout', 'Logout')
];

final Map<String, IconData> iconMap = {
  'person': Icons.person,
  'setting': Icons.settings,
  'help': Icons.help,
  'logout': Icons.logout
};