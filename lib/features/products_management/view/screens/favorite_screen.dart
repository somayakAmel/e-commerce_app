import 'package:e_commerce/features/products_management/view_model/product_details/product_details_cubit.dart';
import 'package:e_commerce/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../utils/dialog.dart';
import '../../../../utils/routes.dart';
import '../../model/product.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 5,
              ),
              const Text("Favorite Products",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.w500)),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    if (ProductDetailsCubit.get(context)
                        .favoriteProducts
                        .isNotEmpty) {
                      CustomSimpleDialog.showCustomDialog(context, "Clear", () {
                        ProductDetailsCubit.get(context).clearFavorite();
                        Navigator.pop(context);
                      }, "Clear",
                          "'Are you sure you want to clear your favorites?'");
                    } else {
                      showToast(context, "Your favorites is empty",
                          ToastificationType.warning);
                    }
                  },
                  icon: const Icon(Icons.delete, color: Colors.black)),
              const SizedBox(
                width: 5,
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 30,
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
        List<Product> products =
            ProductDetailsCubit.get(context).favoriteProducts;

        if (products.isEmpty) {
          return Center(
            child: Image.asset("assets/images/empty.png"),
          );
        } else {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.productDetail,
                              arguments: products[index]);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: Image.asset(
                                        "assets/images/${products[index].productId}1.jpg"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(products[index].name,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "\$${products[index].price.truncate()}",
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          icon:
                                              const Icon(Icons.delete_outline),
                                          onPressed: () {
                                            ProductDetailsCubit.get(context)
                                                .removeFavorite(
                                                    products[index]);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ])),
                      );
                    }),
              ),
            ],
          );
        }
      }),
    );
  }
}
