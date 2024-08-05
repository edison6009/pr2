//Api support
import 'dart:convert';
//Api support
import 'package:pr2/Api/Response/ServiceResponse.dart';

class SuccessResponse {
  final Map<String, dynamic> body;
  final int statusCode;

  SuccessResponse({
    required this.body,
    required this.statusCode,
  });

  factory SuccessResponse.fromServiceResponse(ServiceResponse ServiceResponse) {
    // Obtén el cuerpo de la respuesta y asegúrate de que no sea nulo
    return SuccessResponse(
      body: ServiceResponse.body,
      statusCode: ServiceResponse.statusCode,
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
