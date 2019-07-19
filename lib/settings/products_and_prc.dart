import 'package:flutter/material.dart';
import 'package:fashion_paradise/fashion_data.dart';

class ProductsCard extends StatelessWidget {
  ProductsCard({@required this.title, @required this.onPressed});

  final String title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        RawMaterialButton(
          onPressed: onPressed,
          child: Icon(
            Icons.edit,
            color: Colors.blue,
          ),
          constraints: BoxConstraints.tightFor(
            width: 34.0,
            height: 34.0,
          ),
          fillColor: Color(0xFFECF0F1),
          shape: CircleBorder(),
          elevation: 0,
        ),
      ],
    );
  }
}
