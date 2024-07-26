import 'package:e_commerce/features/products_management/model/product.dart';
import 'package:e_commerce/features/products_management/view_model/product_details/product_details_cubit.dart';
import 'package:e_commerce/features/shopping_cart/view_model/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../utils/toast.dart';
import '../widgets/product_images.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    double rating = ProductDetailsCubit.get(context).calculateRating(product);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ProductImage(
              images: [
                'assets/images/${product.productId.toString()}1.jpg',
                'assets/images/${product.productId.toString()}2.jpg',
                'assets/images/${product.productId.toString()}3.jpg',
                'assets/images/${product.productId.toString()}4.jpg',
              ],
              product: product,
            ),
            const SizedBox(height: 16.0),
            // Details Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                  builder: (context, state) {
                    return Row(children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_drop_up),
                        onPressed: () {
                          ProductDetailsCubit.get(context).incrementQuantity();
                        },
                      ),
                      Text(
                        ProductDetailsCubit.get(context).quantity.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          ProductDetailsCubit.get(context).decrementQuantity();
                        },
                      ),
                    ]);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 21.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                return Icon(
                  index + 1 < rating
                      ? Icons.star
                      : index + 1 == rating + 0.5
                          ? Icons.star_half
                          : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ),

            const Spacer(),
            Text(
              "Last price: \$${product.price.toString()}",
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Text(
                    "\$${product.price - product.price * product.discount / 100}",
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  MaterialButton(
                    onPressed: () {
                      if (product.availability == false) {
                        // product unavailable!
                        showToast(context, "Out of stock",
                            ToastificationType.warning);
                      } else {
                        // Add to cart
                        CartCubit.get(context).addItem(
                            product.productId.toString(),
                            product.name,
                            product.price,
                            ProductDetailsCubit.get(context).quantity);
                        showToast(context, "Added to cart",
                            ToastificationType.success);
                        ProductDetailsCubit.get(context).resetQuantity();
                      }
                    },
                    minWidth: 230,
                    height: 46,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    color: product.availability ? Colors.black : Colors.grey,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8.0),
                        Text('Add to Cart',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
