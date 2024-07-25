import 'package:e_commerce/features/products_management/model/product.dart';
import 'package:flutter/material.dart';

import '../widgets/product_images.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final Product product;

  double calculateRating() {
    if (product.reviews != []) {
      double sum = 0.0;
      double result = 0.0;
      for (int i = 0; i < product.reviews!.length; i++) {
        sum += product.reviews![i].rating;
        if (i == product.reviews!.length - 1) {
          result = sum / product.reviews!.length;
        }
      }
      return result;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            ),
            const SizedBox(height: 16.0),
            // Details Section
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                return Icon(
                  index + 1 < calculateRating()
                      ? Icons.star
                      : index + 1 == calculateRating() + 0.5
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
                    onPressed: () {},
                    minWidth: 230,
                    height: 46,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    color: Colors.black,
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
