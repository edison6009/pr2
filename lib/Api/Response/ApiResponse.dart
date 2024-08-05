//Api support
import 'dart:convert';

class ApiResponse {
  final Map<String, dynamic> body; // Contenido de la respuesta
  final int statusCode; // Código de estado HTTP

  ApiResponse(this.body, this.statusCode);

  factory ApiResponse.fromJsonString(String jsonString, int statusCode) {
    // Deserializa la cadena JSON directamente en el constructor
    return ApiResponse(jsonDecode(jsonString), statusCode);
  }
}
