import 'package:flutter/material.dart';
import 'package:fashion_paradise/calculator/calculator_brain.dart';
import 'package:fashion_paradise/fashion_data.dart';

String addedProduct;

int profitNotChanged = 50;
double fixedCostNotChanged;
bool validateInput = false;
bool keyBoard = true;

double usdRmb = rates[0];
double rtgsRmb = rates[1];
double randsRmb = rates[2];

double holdMinCost = 30.0;
double holdMaxCost = 70.0;

void getCurrentFixedCostOfProducts(String name) {
  if (productsText[name] != null) {
    fixedCostNotChanged = productsText[name];
  }
}

class DialogCard extends StatelessWidget {
  void categoryValidation(String category, bool isDone) {
    keyBoard = true;
    switch (category) {
      case 'Profit':
        isDone
            ? profitNotChanged = profitPercent
            : profitPercent = profitNotChanged;

        break;
      case 'products':
        isDone
            ? fixedCostNotChanged = fixedCost
            : productsText[title] = fixedCostNotChanged;
        break;
      case 'addProduct':
        {
          validateInput = false;
          if (isDone) {
            if (addedProduct != null && addedProduct != '') {
              if (fixedCost == null) {
                fixedCost = (maxCost + minCost) / 2;
              }
              productsText[addedProduct] = fixedCost;
            }
          } else {
            addedProduct = null;
          }
        }

        break;
      case 'Cost':
        {
          if (isDone) {
            if (minCost < maxCost) {
              holdMaxCost = maxCost;
              holdMinCost = minCost;
            } else {
              maxCost = holdMaxCost;
              minCost = holdMinCost;
            }
          } else {
            maxCost = holdMaxCost;
            minCost = holdMinCost;
          }
        }
        break;
      case 'rates':
        {
          if (isDone) {
            if (usdRmb != rates[0] ||
                rtgsRmb != rates[1] ||
                randsRmb != rates[2]) {
              usdRmb = rates[0];
              rtgsRmb = rates[1];
              randsRmb = rates[2];
            }
          } else {
            rates[0] = usdRmb;
            rates[1] = rtgsRmb;
            rates[2] = randsRmb;
          }
        }
    }
  }

  Widget changeCategory(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      switch (categoryName) {
        case 'Profit':
          return CostsContentCard(
            onChanged: (double value) {
              setState(() {
                profitPercent = value.round();
              });
            },
            changeValue: '$profitPercent%',
          );
          break;
        case 'Cost':
          return CostMinMax(
            onTap: () {
              setState(() {
                keyBoard = true;
              });
            },
          );
          break;
        case 'products':
          {
            return ProductsContentCard(
              fixedCost: fixedCost,
              onChangedProducts: (double value) {
                setState(() {
                  fixedCost = value.roundToDouble();
                  productsText[title] = fixedCost;
                });
              },
            );
          }

          break;
        case 'rates':
          return RatesCard(
            onTap: () {
              setState(() {
                keyBoard = true;
              });
            },
          );
          break;
        case 'addProduct':
          return AddProductCard(
            onTap: () {
              setState(() {
                keyBoard = true;
              });
            },
            fixedCost: fixedCost == null ? 50.0 : fixedCost,
            onChange: (double value) {
              setState(() {
                fixedCost = value.roundToDouble();
                keyBoard = false;
              });
            },
            onSubmit: (String product) {
              if (product.isEmpty) {
                validateInput = true;
              } else {
                validateInput = false;
              }
            },
          );
          break;
      }
    });
  }

  DialogCard(
      {@required this.title, @required this.categoryName, this.fixedCost});
  final String title;
  final String categoryName;
  double fixedCost;
  @override
  Widget build(BuildContext context) {
    getCurrentFixedCostOfProducts(title);
    return AlertDialog(
      backgroundColor: Color(0xFFECF0F1),
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
            color: Colors.blue,
          ),
        ),
      ),
      content: changeCategory(context),
      //TODO: to refactor actions buttons
      actions: <Widget>[
        RawMaterialButton(
          onPressed: () {
            keyBoard = false;
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) {
                  categoryValidation(categoryName, false);
                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.of(context).pop();
                  });
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 50.0,
                    ),
                  );
                });
          },
          child: Icon(
            Icons.clear,
            color: Colors.red,
            size: 30.0,
          ),
          constraints: BoxConstraints.tightFor(
            width: 56.0,
            height: 56.0,
          ),
          fillColor: Color(0xFFFFFFFF),
          shape: CircleBorder(),
        ),
        SizedBox(
          width: 100.0,
        ),
        RawMaterialButton(
          onPressed: () {
            keyBoard = false;
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) {
                  categoryValidation(categoryName, true);
                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.of(context).pop();
                  });
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: Icon(
                      Icons.done,
                      color: Colors.green,
                      size: 50.0,
                    ),
                  );
                });
          },
          child: Icon(
            Icons.done,
            color: Colors.green,
            size: 30.0,
          ),
          constraints: BoxConstraints.tightFor(
            width: 56.0,
            height: 56.0,
          ),
          fillColor: Color(0xFFFFFFFF),
          shape: CircleBorder(),
        ),
        SizedBox(
          width: 10.0,
        ),
      ],
    );
  }
}

class CostsContentCard extends StatelessWidget {
  CostsContentCard({@required this.onChanged, @required this.changeValue});

  final Function onChanged;
  final String changeValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            changeValue,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 60.0,
            ),
          ),
          SliderCard(
            initialValue: profitPercent.toDouble(),
            min: 0.0,
            max: 100.0,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class SliderCard extends StatelessWidget {
  SliderCard(
      {@required this.onChanged,
      @required this.initialValue,
      @required this.min,
      @required this.max});

  final Function onChanged;
  final double min;
  final double max;
  final double initialValue;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        inactiveTickMarkColor: Color(0xFFF1F9FF),
        overlayColor: Color(0x992699FB),
        activeTrackColor: Color(0xFF2699FB),
        thumbColor: Color(0xFF2699FB),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
      ),
      child: Slider(
        value: initialValue,
        min: min,
        max: max,
        onChanged: onChanged,
      ),
    );
  }
}

class ProductsContentCard extends StatelessWidget {
  ProductsContentCard(
      {@required this.onChangedProducts, @required this.fixedCost});

  final Function onChangedProducts;
  final double fixedCost;

  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      child: Column(
        children: <Widget>[
          Text(
            'Fixed Costs',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          Text(
            '¥$fixedCost',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 45.0,
              color: Colors.blue,
            ),
          ),
          SliderCard(
            min: minCost,
            max: maxCost,
            initialValue: fixedCost,
            onChanged: onChangedProducts,
          ),
        ],
      ),
    );
  }
}

class AddProductCard extends StatelessWidget {
  AddProductCard(
      {@required this.onChange,
      @required this.fixedCost,
      @required this.onSubmit,
      @required this.onTap});
  final Function onChange;
  final Function onSubmit;
  final fixedCost;
  final Function onTap;

  Widget build(BuildContext context) {
    return Container(
      height: 270.0,
      child: Column(
        children: <Widget>[
          Theme(
            data: ThemeData(
              primaryColor: Colors.white,
              primaryColorDark: Colors.white,
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                color: Color(0xFFECF0F1),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  enabled: keyBoard,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  decoration: InputDecoration(
                    errorText: validateInput ? 'input Product Name' : null,
                    labelText: 'Product Name',
                    labelStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(23),
                      ),
                    ),
                  ),
                  onChanged: (String product) {
                    addedProduct = product;
                  },
                  onSubmitted: onSubmit,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ProductsContentCard(
            onChangedProducts: onChange,
            fixedCost: fixedCost,
          ),
        ],
      ),
    );
  }
}

class CostMinMax extends StatelessWidget {
  CostMinMax({@required this.onTap});
  final Function onTap;
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        children: <Widget>[
          TextFieldCard(
            onTap: onTap,
            cost: '$minCost',
            label: 'Minimum',
            onChange: (String text) {
              if (text.isNotEmpty) {
                minCost = double.parse(text);
              }
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFieldCard(
            onTap: onTap,
            cost: '$maxCost',
            label: 'Maximum',
            onChange: (String text) {
              if (text.isNotEmpty) {
                maxCost = double.parse(text);
              }
            },
          ),
        ],
      ),
    );
  }
}

class RatesCard extends StatelessWidget {
  RatesCard({@required this.onTap});
  final Function onTap;
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        children: <Widget>[
          TextFieldCard(
            onTap: onTap,
            cost: '${rates[0]}',
            label: 'USD/RMB',
            onChange: (String text) {
              if (text.isNotEmpty) {
                rates[0] = double.parse(text);
              }
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFieldCard(
            onTap: onTap,
            cost: '${rates[1]}',
            label: 'RTGS/RMB',
            onChange: (String text) {
              if (text.isNotEmpty) {
                rates[1] = double.parse(text);
              }
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFieldCard(
            onTap: onTap,
            cost: '${rates[2]}',
            label: 'RANDS/RMB',
            onChange: (String text) {
              if (text.isNotEmpty) {
                rates[3] = double.parse(text);
              }
            },
          ),
        ],
      ),
    );
  }
}

class TextFieldCard extends StatelessWidget {
  TextFieldCard(
      {@required this.cost,
      @required this.label,
      @required this.onChange,
      @required this.onTap});
  final Function onChange;
  final String cost;
  final Function onTap;
  final label;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
        primaryColorDark: Colors.white,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Color(0xFFECF0F1),
          child: TextField(
            enabled: keyBoard,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
              hintText: cost,
              prefixText: '¥',
              prefixStyle: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              labelText: label,
              labelStyle: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(23),
                ),
              ),
            ),
            onChanged: onChange,
          ),
        ),
      ),
    );
  }
}
