import 'package:http/http.dart' as http;
import 'package:pr2/Api/Response/ServiceResponse.dart';
import 'package:pr2/Constants/Constants.dart';
import 'dart:convert';

class CountryShow {
  Future<ServiceResponse> showCountry(int id) async {
    final url = Uri.parse('${ApiUrl.baseUrl}country/$id/');

    var response = await http.get(url);

    return ServiceResponse.fromJsonString(
      utf8.decode(response.bodyBytes),
      response.statusCode,
    );
  }
}

class CountryIndex {
  Future<ServiceResponse> fetchData(Map<String, String?> filters) async {
    var uri = Uri.parse('${ApiUrl.baseUrl}country/');

    if (filters.isNotEmpty) {
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
    final url = Uri.parse('${ApiUrl.baseUrl}country/create/');

    final body = jsonEncode({
      'name': name,
      'abbreviation': abbreviation,
      'dialing_code': dialing_code,
    });

    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    return ServiceResponse.fromJsonString(
      utf8.decode(response.bodyBytes),
      response.statusCode,
    );
  }
}

class CountryUpdate{
  Future<ServiceResponse> updateCountry(
      String name, String abbreviation, String dialing_code, int id) async {
    final url = Uri.parse('${ApiUrl.baseUrl}country/update/$id/');

    final body = jsonEncode({
      'name': name,
      'abbreviation': abbreviation,
      'dialing_code': dialing_code,
    });

    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    return ServiceResponse.fromJsonString(
      utf8.decode(response.bodyBytes),
      response.statusCode,
    );
  }
}



