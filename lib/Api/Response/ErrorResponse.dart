//Flutter native support
import 'package:pr2/Api/Response/ServiceResponse.dart';

class SimpleErrorResponse {
  final Map<String, dynamic> body;
  final int statusCode;

  SimpleErrorResponse({
    required this.body,
    required this.statusCode,
  });

  factory SimpleErrorResponse.fromServiceResponse(ServiceResponse ServiceResponse) {
    return SimpleErrorResponse(
      body: ServiceResponse.body,
      statusCode: ServiceResponse.statusCode,
    );
  }

  String get message {
    return body['validation'] as String;
  }

  @override
  String toString() {
    return 'Status Code: $statusCode, Message: $message';
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ValidationResponse {
  final List<String> fieldNames;
  final List<String> messages;

  ValidationResponse({
    required this.fieldNames,
    required this.messages,
  });

  factory ValidationResponse.fromServiceResponse(ServiceResponse serviceResponse) {
    final validationData = serviceResponse.body['validation'];

    List<String> names = [];
    List<String> msgs = [];

    if (validationData is Map<String, dynamic>) {
      validationData.forEach((fieldName, errors) {
        names.add(fieldName);
        msgs.addAll(List<String>.from(errors));
      });
    }

    return ValidationResponse(
      fieldNames: names,
      messages: msgs,
    );
  }

  List<List<String>> validation() {
    return [fieldNames, messages];
  }
}


