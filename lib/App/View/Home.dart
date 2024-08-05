//Flutter native support
import 'package:flutter/material.dart';
import 'Countries.dart'; // Importa la nueva vista
//Api support
import 'package:pr2/Api/Command/CountryCommand.dart';
import 'package:pr2/Api/Service/CountryService.dart';
import 'package:pr2/Api/Response/ServiceResponse.dart';
import 'package:pr2/Api/Response/SuccessResponse.dart';
import 'package:pr2/Api/Response/InternalServerError.dart';
//App suporrt
import 'package:pr2/App/Widget/PopupWindow.dart';
import 'package:pr2/App/Widget/CustomForm.dart';

/// Clase para la vista principal llamada Home que contiene el formulario personalizado.
class Home extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController abbreviationController = TextEditingController();
  final TextEditingController dialingCodeController = TextEditingController();
    final TextEditingController asdasdadsads = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomForm(
          controllers: [
            nameController,
            abbreviationController,
            dialingCodeController,
          ],
          fieldLabels: [
            'Name',
            'Abbreviation',
            'Dialing Code',
          ],
          buttonLabel: 'Submit',
          onButtonPressed: () async {
            // Crear una instancia de CountryCreate
            var countryCreateService = CountryCreate();

            // Crear una instancia de CountryCommandCreate
            var commandCreate = CountryCommandCreate(countryCreateService);

            // Obtener valores de los campos de texto
            String name = nameController.text;
            String abbreviation = abbreviationController.text;
            String dialingCode = dialingCodeController.text;

            // Llamar a execute con los valores de los campos
            var response =
                await commandCreate.execute(name, abbreviation, dialingCode);

            // Mostrar el PopupWindow con el resultado
            showDialog(
              context: context,
              builder: (BuildContext context) {
                if (response is SuccessResponse) {
                  // Manejar la respuesta exitosa
                  return PopupWindow(
                    title: 'Success',
                    message: response.message, // Mensaje del cuerpo
                  );
                } else if (response is InternalServerError) {
                  // Manejar el error
                  return PopupWindow(
                    title: 'Error',
                    message: response.title, // Mostrar el error
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

            // Limpiar los campos de texto después de enviar
            nameController.clear();
            abbreviationController.clear();
            dialingCodeController.clear();
          },
        ),
      ),
    );
  }
}
