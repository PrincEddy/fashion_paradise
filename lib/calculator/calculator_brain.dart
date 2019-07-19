import 'calculator_screen.dart';
import 'package:fashion_paradise/fashion_data.dart';

String numbers = '';
bool commaPressed = false;
bool returnToCalc = false;
int profitPercent = 50;
double minCost = 30.0;
double maxCost = 70.0;
double profit;
double costs;
double input;
double fixedCosts = productsText[showProduct];
double price;
List displayResults;
String showCosts;
String showProfit;
String showPrice;

class CalculatorBrain {
  static String showNumbers(String num) {
    if (num == '=') {
      if (numbers.length == 0 || numbers[0] == '0') {
        showProduct = productsText.keys.elementAt(0);
        fixedCosts = productsText[showProduct];
        commaPressed = false;
        numbers = '';
        return '';
      }
      input = double.parse(numbers);
      numbers = '';
      return '=';
    } else if (returnToCalc && (num != '=')) {
      showProduct = productsText.keys.elementAt(0);
      fixedCosts = productsText[showProduct];
      if (num == '.') {
        numbers += '0.';
        commaPressed = true;
        return '0.';
      }
      numbers += num;
    } else if (numbers.length < 6) {
      if (num == '.' && !commaPressed) {
        commaPressed = true;
        if (numbers.length == 0) {
          numbers += '0.';
          return numbers;
        }
        numbers += num;
      } else if ((num != '.' || num != '=') && numbers == '0') {
        if (num == '0') {
          numbers = '';
        } else {
          numbers = '';
          numbers += num;
        }
      } else {
        if (num == '.') {
          return numbers;
        }
        numbers += num;
      }
    }
    return numbers;
  }

  static void clearStringNumbers() {
    numbers = '';
    commaPressed = false;
  }

  static void calculateAll() {
    costs = (input + fixedCosts);
    profit = costs * (profitPercent / 100);
    price = costs + profit;
  }

  static changeCurrency(int change) {
    if (change == 0) {
      showPrice = '\$' + (price / rates[0]).toStringAsFixed(0);
      showCosts = '\$' + (costs / rates[0]).toStringAsFixed(0);
      showProfit = '\$' + (profit / rates[0]).toStringAsFixed(0);
    } else if (change == 1) {
      showPrice = 'R' + (price * rates[2]).toStringAsFixed(0);
      showCosts = 'R' + (costs * rates[2]).toStringAsFixed(0);
      showProfit = 'R' + (profit * rates[2]).toStringAsFixed(0);
    } else if (change == 2) {
      showPrice = 'RT' + (price / rates[1]).toStringAsFixed(0);
      showCosts = 'RT' + (costs / rates[1]).toStringAsFixed(0);
      showProfit = 'RT' + (profit / rates[1]).toStringAsFixed(0);
    }
  }
}
