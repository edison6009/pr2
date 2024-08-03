import 'package:flutter/material.dart';
import 'package:pr2/Api/Model/CountryModel.dart';
import 'package:pr2/Api/Service/CountryService.dart';
import 'package:pr2/Constants/Constants.dart';

class CountryCommandIndex {
  final CountryIndex _countryData;

  CountryCommandIndex(this._countryData);

  Future<dynamic> execute() async {
    try {
      var apiResponse = await _countryData.fetchData();

      if (apiResponse.statusCode == 200) {
        // Convierte el mapa JSON a un modelo
        return CountryModel.fromJson(apiResponse.body);
      } else {
        // Retorna el error formateado
        return ApiResponseErrorServer.fromApiResponse(apiResponse);
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
      var apiResponse = await _countryCreateService.createCountry(
          name, abbreviation, dialing_code);

      if (apiResponse.statusCode == 201) {
        // Retorna un objeto ApiResponseSuccess
          return ApiResponseSuccess.fromApiResponse(apiResponse);
      } else {
        // Para otros códigos de estado, incluyendo el 500
          return ApiResponseErrorServer.fromApiResponse(apiResponse);
      }
    } on FlutterError catch (flutterError) {
      // Maneja errores específicos de Flutter
      throw Exception(
          'Error en la aplicación Flutter: ${flutterError.message}');
    }
  }
}





