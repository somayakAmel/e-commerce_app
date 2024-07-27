import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast(BuildContext context, String text, ToastificationType type,
    {int timer = 2}) {
  toastification.show(
    context: context,
    title: Text(text),
    autoCloseDuration: Duration(seconds: timer),
    type: type,
    borderRadius: BorderRadius.circular(15),
    style: ToastificationStyle.flat,
    primaryColor: Colors.black,
    closeOnClick: true,
  );
}
