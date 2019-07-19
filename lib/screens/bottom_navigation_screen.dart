import 'package:flutter/material.dart';
import 'package:fashion_paradise/componets/bottom_navigator_bars.dart';
import 'package:fashion_paradise/componets/home_card.dart';
import 'package:fashion_paradise/fashion_data.dart';
import 'package:fashion_paradise/settings/settings.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const String id = 'bottom_navigation_screen';

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> optionBottomNavSelection = [
      Container(),
      makeContainer(),
      Container(),
      SettingsListCard(),
    ];

    return Scaffold(
      appBar: selectedIndex == 1
          ? PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: AppBar(
                title: Text(
                  titles[selectedIndex],
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : AppBar(
              title: Text(
                titles[selectedIndex],
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      body: optionBottomNavSelection.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationCard(
        onTap: (int item) {
          setState(() {
            selectedIndex = item;
            isSelected = false;
          });
        },
      ),
    );
  }
}
