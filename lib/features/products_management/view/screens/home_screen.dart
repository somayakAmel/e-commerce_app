import 'package:e_commerce/features/products_management/view_model/get_product/get_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/utils/inputs.dart';
import '../../model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/product_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                buildTextField(
                  onChanged: (value) {
                    GetProductCubit.get(context).searchProductsList(value);
                  },
                  controller: TextEditingController(),
                  label: 'Search',
                  validator: (p0) => null,
                  icon: Icons.search,
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
          return ProductsList(products: products);
        }));
  }
}
