import 'package:flutter/material.dart';
// Importa el archivo home.dart desde la ruta correcta
import 'package:pr2/app/view/home.dart'; // Ajusta el import según tu estructura

void main() {
  // Ejecutar directamente el widget Home definido en home.dart
  runApp(MyApp());
}

// Definición de la clase MyApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      home: Home(), // Usa el widget Home que ya creaste en home.dart
    );
  }
}
