import 'package:e_commerce/features/products_management/view_model/product_details/product_details_cubit.dart';
import 'package:flutter/material.dart';

import '../../model/product.dart';

class ProductImage extends StatefulWidget {
  const ProductImage({super.key, required this.images, required this.product});
  final List images;
  final Product product;

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.images.length,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.asset(
                  widget.images[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          Positioned(
            bottom: 10.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  height: 8.0,
                  width: currentPage == index ? 24.0 : 8.0,
                  decoration: BoxDecoration(
                    color: currentPage == index ? Colors.black : Colors.grey,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                );
              }),
            ),
          ),
          Positioned(
              top: 10.0,
              right: 10.0,
              child: IconButton(
                  onPressed: () {
                    ProductDetailsCubit.get(context)
                        .toggleFavorite(widget.product);
                    setState(() {});
                  },
                  icon: ProductDetailsCubit.get(context)
                          .isFavoriteOrNot(widget.product)
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border))),
          Positioned(
              top: 10.0,
              left: 5.0,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)))
        ],
      ),
    );
  }
}
