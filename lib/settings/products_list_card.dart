import 'package:flutter/material.dart';
import 'package:fashion_paradise/fashion_data.dart';
import 'products_and_prc.dart';
import 'alert_dialogs.dart';

class ProductListCard extends StatelessWidget {
  final List<ProductsCard> productsList = [];
  makeProductList(BuildContext context) {
    for (var product in productsText.keys) {
      productsList.add(
        ProductsCard(
          title: product,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return DialogCard(
                    fixedCost: productsText[product],
                    title: product,
                    categoryName: 'products',
                  );
                });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    makeProductList(context);
    return Container(
      height: 100.0,
      child: ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (BuildContext products, int index) {
          return productsList[index];
        },
      ),
    );
  }
}
