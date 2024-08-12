// lib/App/View/Index.dart
import 'package:flutter/material.dart';
import 'package:pr2/Api/Model/CountryModel.dart';
import 'package:pr2/Api/Command/CountryCommand.dart';
import 'package:pr2/Api/Service/CountryService.dart';
import 'package:pr2/App/Widget/CustomButton.dart';
import 'package:pr2/App/Widget/CountryListView.dart'; // Importa el nuevo widget

class Index extends StatefulWidget {
  final String? name_;

  Index({this.name_});

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final filters = {
    'pag=': '15', // Cambiado a String
    'page=': null,
    'name=': null,
  };

  List<Country> countries = []; // Variable de estado para almacenar los países

  Future<void> fetchCountries() async {
    if (widget.name_ != null && widget.name_!.isNotEmpty) {
      filters['name='] = widget.name_;
    } else {
      filters['name='] =
          null; // Asegúrate de que se elimine el filtro si el nombre es nulo
    }

    final countryIndex = CountryIndex();
    final countryCommand = CountryCommandIndex(countryIndex, filters);

    try {
      // Ejecuta el comando y obtiene la respuesta
      var response = await countryCommand.execute();

      setState(() {
        countries = response.results.countries; // Actualiza la lista de países
      });
    } catch (e) {
      // Maneja y muestra cualquier error que ocurra
      print('Error: $e');
    }
  }

  void reloadView() {
    fetchCountries();
  }

  @override
  void initState() {
    super.initState();
    fetchCountries(); // Llama a fetchCountries en lugar de initialize
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Index'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hola Mundo',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            CustomButton(
              label: 'Recargar Vista',
              onPressed:
                  reloadView, // Pasa la referencia a la función que recarga la vista
            ),
            SizedBox(height: 20),
            // Llama al widget CountryListView y pasa los datos de los países
            CountryListView(countries: countries),
          ],
        ),
      ),
    );
  }
}
