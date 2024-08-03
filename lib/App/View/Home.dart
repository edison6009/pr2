import 'package:flutter/material.dart';
import 'package:pr2/Api/Command/CountryCommand.dart';
import 'package:pr2/Api/Service/CountryService.dart';
import 'package:pr2/App/Widget/PopupWindow.dart';
import 'package:pr2/Constants/Constants.dart';
import 'Countries.dart'; // Importa la nueva vista

class Home extends StatelessWidget {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _abbreviation = TextEditingController();
  final TextEditingController _dialing_code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Simple'), // Título de la app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espacio alrededor del formulario
        child: Form(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Alineación a la izquierda
            children: <Widget>[
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: 'Primer Campo', // Etiqueta para el primer input
                  border: OutlineInputBorder(), // Borde para el input
                ),
              ),
              SizedBox(height: 16.0), // Espacio entre los campos
              TextFormField(
                controller: _abbreviation,
                decoration: InputDecoration(
                  labelText: 'Segundo Campo', // Etiqueta para el segundo input
                  border: OutlineInputBorder(), // Borde para el input
                ),
              ),
              SizedBox(height: 16.0), // Espacio entre los campos
              TextFormField(
                controller: _dialing_code,
                decoration: InputDecoration(
                  labelText: 'Tercer Campo', // Etiqueta para el tercer input
                  border: OutlineInputBorder(), // Borde para el input
                ),
              ),
              SizedBox(height: 32.0), // Espacio antes del botón
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Crear una instancia de CountryCreate
                    var countryCreateService = CountryCreate();

                    // Crear una instancia de CountryCommandCreate
                    var commandCreate = CountryCommandCreate(countryCreateService);

                    // Obtener valores de los campos de texto
                    String name = _name.text;
                    String abbreviation = _abbreviation.text;
                    String dialingCode = _dialing_code.text;

                    // Llamar a execute con los valores de los campos
                    var response = await commandCreate.execute(name, abbreviation, dialingCode);

                    // Mostrar el PopupWindow con el resultado
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        if (response is ApiResponseSuccess) {
                          // Manejar la respuesta exitosa
                          return PopupWindow(
                            title: 'Éxito', // Título para respuesta exitosa
                            message: response.message, // Mensaje del cuerpo
                          );
                        } else if (response is ApiResponseErrorServer) {
                          // Manejar el error
                          return PopupWindow(
                            title: 'Error',
                            message: response.message, // Mostrar el primer título directamente
                          );
                        } else {
                          // Manejo de casos imprevistos
                          return PopupWindow(
                            title: 'Error',
                            message: 'Se produjo un error inesperado.',
                          );
                        }
                      },
                    );


                    // Limpiar los campos de texto
                    _name.clear();
                    _abbreviation.clear();
                    _dialing_code.clear();
                  },


                  child: Text('Enviar'), // Texto del botón
                ),
              ),
              SizedBox(height: 32.0), // Espacio antes de los nuevos botones
              Column(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (index == 0) {
                          // Navegar a la nueva vista "Countries"
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Countries()),
                          );
                        }
                        // Añade las acciones de los otros botones aquí
                      },
                      child: Text('Botón ${index + 1}'), // Texto del botón
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
