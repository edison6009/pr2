import 'package:flutter/material.dart';
import 'package:pr2/App/Widget/CustomButton.dart'; // Asegúrate de importar correctamente el archivo donde está tu widget CustomButton
import 'package:pr2/app/view/Post/Post.dart';
import 'package:pr2/app/view/Index/Index.dart';
import 'package:pr2/app/View/Search/Search.dart';

class Render extends StatefulWidget {
  @override
  _RenderState createState() => _RenderState();
}

class _RenderState extends State<Render> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Render')),
      body: Center(
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Ajusta la columna al tamaño mínimo necesario
          children: [
            CustomButton(
              label: 'Post',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Post()),
                );
              },
            ),
            SizedBox(height: 16.0),
            CustomButton(
              label: 'Index',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Index()),
                );
              },
            ),
            SizedBox(height: 16.0),
            CustomButton(
              label: 'Search',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Search()),
                );
              }, // onPressed vacío por ahora
            ),
            SizedBox(height: 16.0),
            CustomButton(
              label: 'Button 4',
              onPressed: () {}, // onPressed vacío por ahora
            ),
            SizedBox(height: 16.0),
            CustomButton(
              label: 'Button 5',
              onPressed: () {}, // onPressed vacío por ahora
            ),
            SizedBox(height: 16.0),
            CustomButton(
              label: 'Button 6',
              onPressed: () {}, // onPressed vacío por ahora
            ),
          ],
        ),
      ),
    );
  }
}
