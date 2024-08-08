import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String text;
  final TextEditingController input;
  final Color border;
  final String? error;

  CustomInput({
    required this.text,
    required this.input,
    this.border = Colors.grey,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: input,
          decoration: InputDecoration(
            hintText: text,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: border),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: border),
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              error!,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
