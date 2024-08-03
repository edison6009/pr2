import 'dart:convert';

class ApiUrl{
  // ---------------------------URL base de la API ---------------------------//

  //url para pruebas locales:
  static const String baseUrl = 'http://127.0.0.1:8000/';

  //url para pruebas en el servidor:
  // static const String baseUrl = 'https://escuchamos.onrender.com';

  // -------------------------------------------------------------------------//
}

class ApiResponse {
  final Map<String, dynamic> body; // Contenido de la respuesta
  final int statusCode; // Código de estado HTTP

  ApiResponse(this.body, this.statusCode);

  factory ApiResponse.fromJsonString(String jsonString, int statusCode) {
    // Deserializa la cadena JSON directamente en el constructor
    return ApiResponse(jsonDecode(jsonString), statusCode);
  }
}

class ApiResponseSuccess {
  final Map<String, dynamic> body;
  final int statusCode;

  ApiResponseSuccess({
    required this.body,
    required this.statusCode,
  });

  factory ApiResponseSuccess.fromApiResponse(ApiResponse apiResponse) {
    // Obtén el cuerpo de la respuesta y asegúrate de que no sea nulo
    return ApiResponseSuccess(
      body: apiResponse.body,
      statusCode: apiResponse.statusCode,
    );
  }

  String get message {
    // Verifica si 'message' está presente en el cuerpo de la respuesta
      return body['message'] as String;

  }

  @override
  String toString() {
    // Asegúrate de que statusCode y message estén presentes
    return 'Status Code: $statusCode, Message: $message';
  }
}

class ApiResponseErrorServer {
  final int code;
  final List<String> title;
  final String errors;

  ApiResponseErrorServer({
    required this.code,
    required this.title,
    required this.errors,
  });

  factory ApiResponseErrorServer.fromApiResponse(ApiResponse apiResponse) {
    final data = apiResponse.body['data'];

    return ApiResponseErrorServer(
      code: data['code'],
      title: List<String>.from(data['title']),
      errors: data['errors'],
    );
  }

  // Getter 'message' que retorna el primer título
  String get message => title[0];

  @override
  String toString() {
    return 'Status Code: $code, Message: $message, Errors: $errors';
  }
}
