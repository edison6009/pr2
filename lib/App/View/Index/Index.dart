import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  final String? value;
  Index({this.value});

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  late Map<String, String> filter;

  @override
  void initState() {
    super.initState();
    filter = {'?name=': widget.value ?? ''};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hola Mundo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 16.0),
                child: Column(
                  children: [
                    Text('Name'),
                    Text(filter['?name='] ?? ''), // Muestra el valor del filtro
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 16.0),
                child: Column(
                  children: [
                    Text('Abbreviation'),
                    Text(''), // Vacío por ahora
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('Dialing Code'),
                    Text(''), // Vacío por ahora
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
