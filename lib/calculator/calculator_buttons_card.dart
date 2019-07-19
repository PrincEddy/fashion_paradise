import 'package:flutter/material.dart';

class OneButtonCard extends StatelessWidget {
  OneButtonCard({@required this.number, @required this.onTap});

  final String number;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color(0xFF2F3542),
        child: MaterialButton(
          onPressed: onTap,
          child: Center(
              child: Text(
            number,
            style: TextStyle(fontSize: 53.0),
          )),
        ),
      ),
    );
  }
}
