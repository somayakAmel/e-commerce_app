import 'package:e_commerce/features/products_management/view/widgets/product_list.dart';
import 'package:e_commerce/features/products_management/view_model/get_product/get_product_cubit.dart';
import 'package:e_commerce/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/utils/inputs.dart';

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
        body: productList());
  }
}
