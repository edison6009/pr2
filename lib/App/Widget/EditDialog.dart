import 'package:flutter/material.dart';

class EditDialog extends StatelessWidget {
  final String field;
  final TextEditingController controller;
  final ValueChanged<String> onTextChanged;
  final VoidCallback onSave;

  EditDialog({
    required this.field,
    required this.controller,
    required this.onTextChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit $field'),
      content: TextField(
        controller: controller,
        autofocus: true,
        onChanged: onTextChanged,
        onSubmitted: (newValue) {
          onSave();
          Navigator.of(context).pop();
        },
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            onSave();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
