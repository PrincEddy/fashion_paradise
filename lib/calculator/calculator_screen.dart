import 'package:flutter/material.dart';
import 'package:fashion_paradise/calculator/calculator_buttons_card.dart';
import 'package:fashion_paradise/fashion_data.dart';
import 'package:fashion_paradise/calculator/calculator_brain.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';

String showNumber = '';
String firstShowNumber = '¥0.00';
bool anyKey = false;
String showProduct = productsText.keys.elementAt(0);

class CalculatorScreen extends StatefulWidget {
  static const String id = 'calculator_screen';
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  Column makeAllButtonsCard() {
    List<Widget> allButtons = [];

    for (int i = 0; i < 4; i++) {
      allButtons.add(
        Expanded(
          child: Container(
            child: makeButtonsRowCard(row[i]),
          ),
        ),
      );
      if (i < 3) {
        allButtons.add(
          SizedBox(
            height: 3.0,
          ),
        );
      }
    }

    return Column(
      children: allButtons,
    );
  }

  Row makeButtonsRowCard(List<String> rowNumbers) {
    List<Widget> allRowButtons = [];
    rowNumbers.forEach((number) {
      allRowButtons.add(
        OneButtonCard(
            number: number,
            onTap: () {
              setState(() {
                showNumber = CalculatorBrain.showNumbers(number);
                if (showNumber == '=') {
                  if (showProduct == productsText.keys.elementAt(0)) {
                    fixedCosts = productsText[showProduct];
                  }

                  CalculatorBrain.calculateAll();
                  CalculatorBrain.changeCurrency(0);
                  returnToCalc = true;
                } else {
                  returnToCalc = false;
                }
              });
            }),
      );
      if (rowNumbers.indexOf(number) < rowNumbers.length - 1) {
        allRowButtons.add(
          SizedBox(
            width: 1.0,
          ),
        );
      }
    });
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: allRowButtons,
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerProducts = [];

    for (String product in productsText.keys) {
      pickerProducts.add(Text(
        product,
        style: TextStyle(
          fontSize: 40.0,
          color: Colors.white,
        ),
      ));
    }

    return CupertinoPicker(
      magnification: 1.5,
      diameterRatio: 0.5,
      backgroundColor: Color(0xFFFFA502),
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          showProduct = productsText.keys.elementAt(selectedIndex);
          fixedCosts = productsText[showProduct];
        });
      },
      itemExtent: 30.0,
      children: pickerProducts,
    );
  }

  int i = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: Color(0xFFFFA502),
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: returnToCalc
                    ? ResultsCard(
                        onTap: () {
                          setState(() {
                            if (i <= 2) {
                              CalculatorBrain.changeCurrency(i);
                              i++;
                            } else {
                              i = 0;
                              CalculatorBrain.changeCurrency(0);
                              i++;
                            }
                          });
                        },
                      )
                    : TopContainerCard(
                        clearPressed: () {
                          setState(() {
                            showNumber = '';
                            CalculatorBrain.clearStringNumbers();
                          });
                        },
                        iOSPicker: iOSPicker(),
                      ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Color(0xFFFFA502),
              child: makeAllButtonsCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class TopContainerCard extends StatelessWidget {
  TopContainerCard({@required this.clearPressed, @required this.iOSPicker});
  final Function clearPressed;
  final CupertinoPicker iOSPicker;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        BackArrowButton(),
        Expanded(
          child: Center(
            child: Container(
              child: iOSPicker,
              height: 58.0,
              width: 234,
              alignment: Alignment.center,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(),
                Expanded(
                  child: AutoSizeText(
                    showNumber == '' ? firstShowNumber : '¥$showNumber',
                    style: TextStyle(
                      fontSize: 80.0,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    minFontSize: 30,
                  ),
                ),
                GestureDetector(
                  onTap: clearPressed,
                  child: Image.asset(
                    'images/clear.png',
                    width: 60.0,
                    height: 60.0,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ResultsCard extends StatelessWidget {
  ResultsCard({@required this.onTap});
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        BackArrowButton(),
        RawMaterialButton(
          onPressed: onTap,
          child: Text(
            showProduct,
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                AutoSizeText(
                  showPrice,
                  style: TextStyle(
                    fontSize: 70.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  minFontSize: 40.0,
                  maxLines: 1,
                ),
                Text('price'),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Expanded(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                AutoSizeText(
                  showCosts,
                  style: TextStyle(
                    fontSize: 60.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  minFontSize: 40.0,
                  maxLines: 1,
                ),
                Text('costs'),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  showProfit,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Color(0xFF2ED573),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('profit'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BackArrowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            showNumber = '';
            CalculatorBrain.clearStringNumbers();
            fixedCosts = productsText[showProduct];
            showProduct = productsText.keys.elementAt(0);
            returnToCalc = false;
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
    );
  }
}
