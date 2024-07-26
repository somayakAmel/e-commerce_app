// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce/utils/buttons.dart';
import 'package:flutter/material.dart';

class CustomSimpleDialog {
  static void showCustomDialog(BuildContext context, String title,
      Function() confirm, String okText, String text) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            content: Text(
              text,
              style: const TextStyle(color: Colors.black54, fontSize: 17),
            ),
            actions: <Widget>[
              defaultButton(
                  width: 100,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Cancel",
                  fontSize: 15,
                  background: Colors.black54,
                  radius: 20),
              defaultButton(
                  background: Colors.black,
                  width: 100,
                  onPressed: confirm,
                  text: okText,
                  fontSize: 15,
                  radius: 20),
            ],
          );
        });
  }
}
