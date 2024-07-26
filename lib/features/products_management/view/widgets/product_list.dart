import 'package:e_commerce/features/products_management/view/widgets/product_tail.dart';
import 'package:e_commerce/features/products_management/view_model/get_product/get_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../model/product.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.custom(
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            pattern: [
              const WovenGridTile(5 / 7),
              const WovenGridTile(
                5 / 7,
                crossAxisRatio: 0.9,
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: products.length + 1,
            (context, index) {
              if (index == products.length) {
                if (index == GetProductCubit.get(context).products.length) {
                  return Container();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        GetProductCubit.get(context).loadMoreProducts();
                      },
                      child: const Text('Load More'),
                    ),
                  );
                }
              }
              return ProductTile(product: products[index]);
            },
          ),
        ));
  }
}
