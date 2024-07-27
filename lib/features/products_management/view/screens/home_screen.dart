import 'dart:async';

import 'package:e_commerce/features/products_management/view/widgets/product_tail.dart';
import 'package:e_commerce/features/products_management/view_model/get_product/get_product_cubit.dart';
import 'package:e_commerce/features/user_management/view_model/auth_cubits/login/login_cubit.dart';
import 'package:e_commerce/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/utils/inputs.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../utils/routes.dart';
import '../../model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool needToLoad = false;

  @override
  void initState() {
    super.initState();
    GetProductCubit.get(context).searchActive = false;
    GetProductCubit.get(context).productsShown =
        GetProductCubit.get(context).products.sublist(0, 6);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (GetProductCubit.get(context).searchActive == false) {
        needToLoad = true;
        Timer(const Duration(seconds: 1), () {
          GetProductCubit.get(context).loadMoreProducts();
        });
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
              toolbarHeight: 100,
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          onChanged: (value) {
                            GetProductCubit.get(context)
                                .searchProductsList(value);
                          },
                          controller: TextEditingController(),
                          label: 'Search',
                          validator: (p0) => null,
                          icon: Icons.search,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            CustomSimpleDialog.showCustomDialog(
                                context, "Logout", () {
                              LoginCubit.get(context).signOut();
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.login);
                            }, "Logout", "Are you sure you want to logout?");
                          },
                          icon: const Icon(Icons.logout_sharp))
                    ],
                  ),
                ],
              )),
          body: BlocConsumer<GetProductCubit, GetProductState>(
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
            return Column(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.custom(
                        controller: _scrollController,
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
                          (context, index) {
                            return ProductTile(product: products[index]);
                          },
                        ),
                      )),
                ),
                if (products.length <
                        GetProductCubit.get(context).products.length &&
                    needToLoad &&
                    GetProductCubit.get(context).searchActive == false)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
              ],
            );
          })),
    );
  }
}
