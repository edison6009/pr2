//Flutter native support
import 'package:flutter/material.dart';
//App suporrt
import 'CustomLabel.dart'; // Asegúrate de tener este archivo
import 'CustomButton.dart';

class CustomForm extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<String> fieldLabels;
  final String buttonLabel;
  final VoidCallback onButtonPressed;

  CustomForm({
    required this.controllers,
    required this.fieldLabels,
    required this.buttonLabel,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < fieldLabels.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextField(
              controller: controllers[i],
              decoration: InputDecoration(
                hintText: fieldLabels[i], // Label dentro del campo
                border: OutlineInputBorder(),
              ),
            ),
          ),
        SizedBox(height: 16),
        CustomButton(
          label: buttonLabel,
          onPressed: onButtonPressed,
        ),
      ],
    );
  }
}
