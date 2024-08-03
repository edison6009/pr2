import 'package:flutter/material.dart';

class Countries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries'), // Título de la app bar
      ),
      body: Center(
        child: Text('Lista de Países'), // Texto de ejemplo
      ),
    );
  }
}
