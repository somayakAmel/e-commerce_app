import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast(BuildContext context, String text, ToastificationType type) {
  toastification.show(
    context: context,
    title: Text(text),
    autoCloseDuration: const Duration(seconds: 2),
    type: type,
    borderRadius: BorderRadius.circular(15),
    style: ToastificationStyle.flat,
    primaryColor: Colors.black,
    closeOnClick: true,
  );
}
