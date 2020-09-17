import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';
import '../providers/products_provider.dart';
import 'package:food_waste/screens/product_details.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;
    return GridView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: const EdgeInsets.all(40),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(ProductDetails.routeName),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
      ),
    );
  }
}
