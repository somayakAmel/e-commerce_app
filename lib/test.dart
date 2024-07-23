//import 'dart:developer';
import 'package:flutter/material.dart';

import 'custom.dart';

//import 'package:Auto_Shop/features/payment_feature/view/widgets/payment_widgets/payment_methods_list_view.dart';

class PaymentDetailsViewBody extends StatefulWidget {
  const PaymentDetailsViewBody({super.key});

  @override
  State<PaymentDetailsViewBody> createState() => _PaymentDetailsViewBodyState();
}

class _PaymentDetailsViewBodyState extends State<PaymentDetailsViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        autovalidateMode = AutovalidateMode.always;
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                    child: Text(
                      'Payment',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    height: 60,
                    shape: CircleBorder(eccentricity: .5),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
