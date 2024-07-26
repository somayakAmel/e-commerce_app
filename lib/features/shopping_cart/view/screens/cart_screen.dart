import 'package:e_commerce/features/shopping_cart/model/cart_item.dart';
import 'package:e_commerce/features/shopping_cart/view_model/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../utils/buttons.dart';
import '../../../../utils/dialog.dart';
import '../../../../utils/toast.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 5,
              ),
              const Text("Cart",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.w500)),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    if (CartCubit.get(context).items.isNotEmpty) {
                      CustomSimpleDialog.showCustomDialog(context, "Clear", () {
                        CartCubit.get(context).clearCart();
                        Navigator.pop(context);
                      }, "Clear",
                          "'Are you sure you want to clear your cart?'");
                    } else {
                      showToast(context, "Your cart is empty",
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
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<CartItemModel> cartItems = CartCubit.get(context).items;
          if (state is CartEmpty || state is CartInitial && cartItems.isEmpty) {
            return Center(
              child: Image.asset("assets/images/empty.png"),
            );
          } else if (state is CartUpdated || cartItems.isNotEmpty) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              return CartItem(item: cartItems[index]);
                            }),
                      ),
                      defaultButton(
                        background: Colors.black,
                        radius: 20,
                        width: 300,
                        fontFamily: "ProtestRiot-Regular",
                        text:
                            "\$${CartCubit.get(context).totalPrice.truncate()}  Check Out Now",
                        fontSize: 20,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
