import 'package:flutter/material.dart';

/// Un widget de ventana emergente que muestra un cuadro de diálogo con un título y un mensaje.
///
/// Este widget se utiliza para mostrar una ventana emergente personalizada
/// en la interfaz de usuario. Acepta un título y un mensaje a través de su
/// constructor, que se muestran en el cuadro de diálogo.
class PopupWindow extends StatelessWidget {
  final String title; // Título del cuadro de diálogo
  final String message; // Mensaje del cuadro de diálogo

  /// Constructor del widget PopupWindow.
  ///
  /// [title] El título que se mostrará en el cuadro de diálogo.
  /// [message] El mensaje que se mostrará en el cuerpo del cuadro de diálogo.
  PopupWindow({
    this.title = '', // Valor por defecto
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title), // Muestra el título proporcionado
      content: Text(message), // Muestra el mensaje proporcionado
      actions: <Widget>[
        TextButton(
          child: Text('OK'), // Texto del botón de acción
          onPressed: () {
            Navigator.of(context)
                .pop(); // Cierra el cuadro de diálogo cuando se presiona el botón
          },
        ),
      ],
    );
  }
}
