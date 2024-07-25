import 'package:e_commerce/features/products_management/view/widgets/product_tail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../model/product.dart';
import 'package:e_commerce/features/products_management/view_model/get_product/get_product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

productList() {
  return BlocConsumer<GetProductCubit, GetProductState>(
      listener: (context, state) {
    if (state is GetProductFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error in fetching products"),
        ),
      );
    } else if (state is GetProductSuccess) {}
  }, builder: (context, state) {
    List<Product> products = GetProductCubit.get(context).productsShown;
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
            childCount: products.length,
            (context, index) => ProductTile(product: products[index]),
          ),
        ));
  });
}
