//Flutter native support
import 'package:flutter/material.dart';
//Api support
import 'package:pr2/Api/Model/CountryModel.dart';
import 'package:pr2/Api/Service/CountryService.dart';
import 'package:pr2/Api/Response/ServiceResponse.dart';
import 'package:pr2/Api/Response/SuccessResponse.dart';
import 'package:pr2/Api/Response/InternalServerError.dart';
import 'package:pr2/Api/Response/ErrorResponse.dart';

class CountryCommandIndex {
  final CountryIndex _countryData;

  CountryCommandIndex(this._countryData);

  Future<dynamic> execute() async {
    try {
      var ServiceResponse = await _countryData.fetchData();
      if (ServiceResponse.statusCode == 200) {
        return CountryModel.fromJson(ServiceResponse.body);
      } else {
        return InternalServerError.fromServiceResponse(ServiceResponse);
      }
    } on FlutterError catch (flutterError) {
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
      var ServiceResponse = await _countryCreateService.createCountry(
          name, abbreviation, dialing_code);
      if (ServiceResponse.statusCode == 201) {
          return SuccessResponse.fromServiceResponse(ServiceResponse);
      } else if (ServiceResponse.statusCode == 500) {
          return InternalServerError.fromServiceResponse(ServiceResponse);
      } else {
          var content = ServiceResponse.body['validation'] ?? ServiceResponse.body['error'];
        if (content is String) {
          return SimpleErrorResponse.fromServiceResponse(ServiceResponse);
        }
        return ValidationResponse.fromServiceResponse(ServiceResponse);         
      }
    } on FlutterError catch (flutterError) {
      throw Exception(
        'Error en la aplicación Flutter: ${flutterError.message}');
    }
  }
}










