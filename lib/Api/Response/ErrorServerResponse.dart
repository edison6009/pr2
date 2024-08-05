//Api support
import 'dart:convert';
//Api support
import 'package:pr2/Api/Response/ApiResponse.dart';

class ErrorServerResponse {
  final int code;
  final List<String> error;
  final String errors;

  ErrorServerResponse({
    required this.code,
    required this.error,
    required this.errors,
  });

  factory ErrorServerResponse.fromApiResponse(ApiResponse apiResponse) {
    final data = apiResponse.body['data'];

    return ErrorServerResponse(
      code: data['code'],
      error: List<String>.from(data['title']),
      errors: data['errors'],
    );
  }

  // Getter 'message' que retorna el primer título
  String get title => error[0];

  @override
  String toString() {
    return 'Status Code: $code, Title: $title, Errors: $errors';
  }
}
