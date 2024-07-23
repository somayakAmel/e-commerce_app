import 'package:flutter/material.dart';

Widget buildSubmitButton({
  Color? bgColor,
  double widthFactor = 1,
  TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 16),
  required String label,
  required void Function()? onPressed,
}) =>
    FractionallySizedBox(
      widthFactor: widthFactor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: textStyle,
        ),
      ),
    );

Widget buildTextButton({
  required void Function()? onPressed,
  required String label,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(label,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          )),
    );

Widget buildOptionButton({
  required void Function()? onTap,
  String? src,
  IconData? icon,
  double radius = 15,
  double iconSize = 28,
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: CircleAvatar(
          radius: radius + 10,
          backgroundColor: const Color.fromARGB(31, 42, 42, 42),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: Colors.transparent,
            backgroundImage:
                src != null ? AssetImage('assets/images/$src.png') : null,
            child: Icon(
              icon,
              size: iconSize,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
