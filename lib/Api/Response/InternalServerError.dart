//Flutter native support
import 'dart:convert';
//Api support
import 'package:pr2/Api/Response/ServiceResponse.dart';

class InternalServerError {
  final int code;
  final List<String> error;
  final String errors;

  InternalServerError({
    required this.code,
    required this.error,
    required this.errors,
  });

  factory InternalServerError.fromServiceResponse(ServiceResponse ServiceResponse) {
    final data = ServiceResponse.body['data'];

    return InternalServerError(
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
