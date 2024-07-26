import 'package:e_commerce/features/shopping_cart/view_model/cart/cart_cubit.dart';
import 'package:e_commerce/utils/routes.dart';
import 'package:e_commerce/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../model/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.productDetail,
            arguments: product);
      },
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 1)],
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      "assets/images/${product.productId.toString()}1.jpg",
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(
                              height: 100,
                              width: 100,
                              child: const Icon(Icons.error)),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.name.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        product.description.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black45, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        '\$${product.price.toString()}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: 10,
            right: 10,
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () {
                    CartCubit.get(context).addItem(
                        product.productId.toString(),
                        product.name.toString(),
                        product.price -
                            product.price * product.discount / 100.toDouble(),
                        1);

                    showToast(
                        context, "Added to cart", ToastificationType.success);
                  },
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                )))
      ]),
    );
  }
}
