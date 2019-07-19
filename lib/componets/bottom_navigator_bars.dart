import 'package:flutter/material.dart';
import 'package:fashion_paradise/fashion_data.dart';

int selectedIndex = 1;
bool isSelected = false;
List<BottomNavigationBarItem> makeBottomNavigator() {
  List<BottomNavigationBarItem> bottomNavigatorItems = [];

  for (int i = 0; i < 4; i++) {
    bottomNavigatorItems.add(
      BottomNavigationBarItem(
        icon: Icon(
          bottomIcons[i],
          size: 30.0,
          color: Colors.white,
        ),
        activeIcon: Icon(
          bottomIcons[i],
          size: 30.0,
          color: Color(0xFF02FF6A),
        ),
        title: Text(
          titles[i],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  return bottomNavigatorItems;
}

class BottomNavigationCard extends StatelessWidget {
  BottomNavigationCard({@required this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: makeBottomNavigator(),
      currentIndex: selectedIndex,
      fixedColor: Colors.white,
    );
  }
}
