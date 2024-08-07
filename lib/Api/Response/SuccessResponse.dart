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
    return SuccessResponse(
      body: ServiceResponse.body,
      statusCode: ServiceResponse.statusCode,
    );
  }

  String get message {
    return body['message'] as String;
  }

  @override
  String toString() {
    return 'Status Code: $statusCode, Message: $message';
  }
}
