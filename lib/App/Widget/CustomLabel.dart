//Flutter native support
import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String text;

  CustomLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.blue,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
