import 'package:flutter/material.dart';
import 'package:fashion_paradise/screens/bottom_navigation_screen.dart';
import 'package:fashion_paradise/calculator/calculator_screen.dart';

void main() => runApp(FashionParadise());

class FashionParadise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFFFF4757),
        scaffoldBackgroundColor: Color(0xFFECF0F1),
        canvasColor: Color(0xFF9A3030),
      ),
      initialRoute: BottomNavigationScreen.id,
      routes: {
        BottomNavigationScreen.id: (context) => BottomNavigationScreen(),
        CalculatorScreen.id: (context) => CalculatorScreen(),
      },
    );
  }
}
