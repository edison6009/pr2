import 'package:http/http.dart' as http;
import 'package:pr2/Api/Response/ApiResponse.dart';
import 'package:pr2/Constants/Constants.dart';
import 'dart:convert';

class CountryIndex {
  Future<ApiResponse> fetchData() async {
    var response = await http.get(Uri.parse('${ApiUrl.baseUrl}country/'));

    // Crea ApiResponse directamente al decodificar la respuesta
    return ApiResponse.fromJsonString(
      utf8.decode(response.bodyBytes),
      response.statusCode,
    );
  }
}

class CountryCreate {
  Future<ApiResponse> createCountry(String name, String abbreviation, String dialing_code) async {
    // Define el URL al que se enviará la solicitud POST
    final url = Uri.parse('${ApiUrl.baseUrl}country/create/');

    // Define el cuerpo de la solicitud POST
    final body = jsonEncode({
      'name': name,
      'abbreviation': abbreviation,
      'dialing_code': dialing_code,
    });

    // Define las cabeceras para la solicitud
    final headers = {
      'Content-Type': 'application/json',
    };

    // Realiza la solicitud POST
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    // Retorna la respuesta de la API envuelta en ApiResponse
    return ApiResponse.fromJsonString(
      utf8.decode(response.bodyBytes),
      response.statusCode,
    );
  }
}



