//Flutter native support
import 'package:flutter/material.dart';
//Api support
import 'package:pr2/Api/Model/CountryModel.dart';
import 'package:pr2/Api/Service/CountryService.dart';
import 'package:pr2/Api/Response/ServiceResponse.dart';
import 'package:pr2/Api/Response/SuccessResponse.dart';
import 'package:pr2/Api/Response/InternalServerError.dart';

class CountryCommandIndex {
  final CountryIndex _countryData;

  CountryCommandIndex(this._countryData);

  Future<dynamic> execute() async {
    try {
      var ServiceResponse = await _countryData.fetchData();

      if (ServiceResponse.statusCode == 200) {
        // Convierte el mapa JSON a un modelo
        return CountryModel.fromJson(ServiceResponse.body);
      } else {
        // Retorna el error formateado
        return InternalServerError.fromServiceResponse(ServiceResponse);
      }
    } on FlutterError catch (flutterError) {
      // Maneja errores específicos de Flutter
      throw Exception(
          'Error en la aplicación Flutter: ${flutterError.message}');
    }
  }
}

class CountryCommandCreate {
  final CountryCreate _countryCreateService;

  CountryCommandCreate(this._countryCreateService);

  Future<dynamic> execute(
      String name, String abbreviation, String dialing_code) async {
    try {
      // Realiza la llamada al servicio para crear un nuevo país
      var ServiceResponse = await _countryCreateService.createCountry(
          name, abbreviation, dialing_code);

      if (ServiceResponse.statusCode == 201) {
        // Retorna un objeto SuccessResponse
          return SuccessResponse.fromServiceResponse(ServiceResponse);
      } else {
        // Para otros códigos de estado, incluyendo el 500
          return InternalServerError.fromServiceResponse(ServiceResponse);
      }
    } on FlutterError catch (flutterError) {
      // Maneja errores específicos de Flutter
      throw Exception(
          'Error en la aplicación Flutter: ${flutterError.message}');
    }
  }
}





