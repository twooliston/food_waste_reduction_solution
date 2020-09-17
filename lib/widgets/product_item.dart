import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../generic_widgets/text.dart';

class ProductItem extends StatelessWidget {
  final String route;
  ProductItem(this.route);
  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
      // "Consumer" instead of "Provider.of()"
      builder: (ctx, product, child) => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                route,
                arguments: product.id,
              );
            },
            child: Image.network(
              product.imageURL,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.75),
            title: BuildText(product.name, null),
          ),
        ),
      ),
    );
  }
}
