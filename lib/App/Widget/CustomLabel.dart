import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String text;

  CustomLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFF606060),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
