import 'package:flutter/material.dart';

List<String> home = [
  'Add Items',
  'Calculator',
  'Pre-Orders',
  'Orders',
  'Delivered'
];

List<String> titles = ['Notifcations', 'Home', 'Earnings', 'Settings'];
List<IconData> bottomIcons = [
  Icons.notifications,
  Icons.home,
  Icons.monetization_on,
  Icons.settings
];

Map<String, IconData> navBar = {
  'Notifcations': Icons.notifications,
  'Home': Icons.home,
  'Earnings': Icons.monetization_on,
  'Settings': Icons.settings,
};

List<List<String>> row = [
  ['9', '8', '7'],
  ['6', '5', '4'],
  ['3', '2', '1'],
  ['.', '0', '='],
];

Map<String, double> productsText = {
  'handbags': 70.0,
  'heels': 60.0,
  'dress': 50.0,
  'jeans': 55.0,
  'coats': 70.0,
  'blouse': 45.0,
  'shirts': 45,
};

List<double> rates = [6.5, 1.5, 2.1];
