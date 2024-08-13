import 'package:http/http.dart' as http;
import 'package:pr2/Api/Response/ServiceResponse.dart';
import 'package:pr2/Constants/Constants.dart';
import 'dart:convert';

class CountryIndex {
  Future<ServiceResponse> fetchData(Map<String, String?> filters) async {
    // Asume que ApiUrl.baseUrl está definido en alguna parte
    var uri = Uri.parse('${ApiUrl.baseUrl}country/');

    if (filters.isNotEmpty) {
      // Agrega los filtros a la URL si existen
      final queryString = filters.entries
          .where((entry) => entry.value != null && entry.value!.isNotEmpty)
          .map((entry) => '${entry.key}${entry.value}')
          .join('&');

      if (queryString.isNotEmpty) {
        uri = uri.replace(query: queryString);
      }
    }

    var response = await http.get(uri);

    return ServiceResponse.fromJsonString(
      utf8.decode(response.bodyBytes),
      response.statusCode,
    );
  }
}

class CountryCreate {
  Future<ServiceResponse> createCountry(String name, String abbreviation, String dialing_code) async {
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

    // Retorna la respuesta de la API envuelta en ServiceResponse
    return ServiceResponse.fromJsonString(
      utf8.decode(response.bodyBytes),
      response.statusCode,
    );
  }
}



