import 'package:flutter/material.dart';
import 'alert_dialogs.dart';
import 'products_and_prc.dart';
import 'products_list_card.dart';

class SettingsListCard extends StatelessWidget {
  void dialogCard() {}

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 456.0,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Color(0xFFECF0F1),
                height: 56.0,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Calculator',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.blue),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  height: 400.0,
                  child: Column(
                    children: <Widget>[
                      ProductsCard(
                        title: 'Profit',
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DialogCard(
                                  categoryName: 'Profit',
                                  title: 'Profit',
                                );
                              });
                        },
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ProductsCard(
                        title: 'Costs',
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DialogCard(
                                  categoryName: 'Cost',
                                  title: 'Cost',
                                );
                              });
                        },
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ProductsCard(
                        title: 'Rates',
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DialogCard(
                                  title: 'Rates',
                                  categoryName: 'rates',
                                );
                              });
                        },
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Container(
                        height: 200.0,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {},
                              child: Text(
                                'Products',
                                style: TextStyle(color: Colors.blue),
                              ),
                              color: Color(0xFFECF0F1),
                            ),
                            ProductListCard(),
                            RaisedButton(
                              shape: CircleBorder(),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DialogCard(
                                        title: 'Add New Product',
                                        categoryName: 'addProduct',
                                      );
                                    });
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 50.0,
                              ),
                              color: Color(0xFF2ED573),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
