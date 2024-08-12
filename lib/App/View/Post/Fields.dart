import 'package:flutter/material.dart';

final input = {
  'name': TextEditingController(),
  'abbreviation': TextEditingController(),
  'dialingCode': TextEditingController(),
};

//validations

final border = {
  'name': Colors.grey,
  'abbreviation': Colors.grey,
  'dialing_code': Colors.grey
};

final Map<String, String?> messages = {
  'name': null,
  'abbreviation': null,
  'dialing_code': null,
};
