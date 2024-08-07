import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Color borderColor;

  CustomInput({
    required this.hintText,
    required this.controller,
    this.borderColor = Colors.grey, // Valor por defecto
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}
