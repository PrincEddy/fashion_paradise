import 'package:flutter/material.dart';
import 'package:fashion_paradise/calculator/calculator_screen.dart';
import 'package:fashion_paradise/fashion_data.dart';

class HomeCard extends StatelessWidget {
  HomeCard({@required this.titleText});

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color(0xFFECF0F1),
        child: MaterialButton(
          onPressed: () {
            if (titleText == 'Calculator') {
              Navigator.pushNamed(context, CalculatorScreen.id);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(),
              Text(
                titleText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Column makeContainer() {
  List<Widget> containerCards = [];
  for (String title in home) {
    containerCards.add(
      HomeCard(
        titleText: title,
      ),
    );
    containerCards.add(
      Divider(
        color: Colors.white,
      ),
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: containerCards,
  );
}
