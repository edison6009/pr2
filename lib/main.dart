import 'package:flutter/material.dart';
import 'package:pr2/app/view/Render.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      home: Render(),
    );
  }
}
