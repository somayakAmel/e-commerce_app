import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast(BuildContext context, String text, ToastificationType type) {
  toastification.show(
    context: context,
    title: Text(text),
    autoCloseDuration: const Duration(seconds: 3),
    type: type,
    borderRadius: BorderRadius.circular(15),
    style: ToastificationStyle.minimal,
    primaryColor: Colors.blue,
  );
}
