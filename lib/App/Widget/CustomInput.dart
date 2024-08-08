import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Color borderColor;
  final String? errorMessage; // Agrega esta línea

  CustomInput({
    required this.hintText,
    required this.controller,
    this.borderColor = Colors.grey, // Valor por defecto
    this.errorMessage, // Agrega esta línea
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
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
        ),
        if (errorMessage != null) // Muestra el mensaje si no es nulo
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorMessage!,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
