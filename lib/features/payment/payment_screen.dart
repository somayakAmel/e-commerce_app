import 'package:e_commerce/features/shopping_cart/view_model/cart/cart_cubit.dart';
import 'package:e_commerce/utils/routes.dart';
import 'package:e_commerce/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../../../../utils/buttons.dart';

import 'custom_credit_card.dart';

//import 'package:Auto_Shop/features/payment_feature/view/widgets/payment_widgets/payment_methods_list_view.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.totalPrice});
  final int totalPrice;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
              //child: PaymentMethodsListView(),
              ),
          SliverToBoxAdapter(
            child: CustomCreditCard(
              autovalidateMode: autovalidateMode,
              formKey: formKey,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 16, right: 16),
                  child: defaultButton(
                    background: Colors.black,
                    radius: 20,
                    width: 200,
                    text: "\$${widget.totalPrice} Pay Now",
                    fontSize: 20,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        autovalidateMode = AutovalidateMode.always;
                        CartCubit.get(context).uploadOrder();
                        CartCubit.get(context).clearCart();

                        Navigator.pushNamed(context, AppRoutes.main);
                        showToast(context, "Payment Successful",
                            ToastificationType.success);
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        showToast(context, "Please Enter Valid Card Details",
                            ToastificationType.warning);
                        setState(() {});
                      }
                    },
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
