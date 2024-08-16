import 'package:flutter/material.dart';
import 'package:pr2/Api/Command/CountryCommand.dart';
import 'package:pr2/Api/Service/CountryService.dart';
import 'package:pr2/Api/Response/ServiceResponse.dart';
import 'package:pr2/Api/Response/SuccessResponse.dart';
import 'package:pr2/Api/Response/InternalServerError.dart';
import 'package:pr2/Api/Response/ErrorResponse.dart';
import 'package:pr2/App/Widget/PopupWindow.dart';
import 'package:pr2/App/Widget/CustomInput.dart';
import 'package:pr2/App/Widget/CustomButton.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final input = {
    'name': TextEditingController(),
    'abbreviation': TextEditingController(),
    'dialing_code': TextEditingController(),
  };

  final border = {
    'name': Colors.grey,
    'abbreviation': Colors.grey,
    'dialing_code': Colors.grey
  };

  final Map<String, String?> messages = {
    'name': null,
    'abbreviation': null,
    'dialing_code': null,
  };

  bool _submitting = false;

  Future<void> _createCountry() async {
    setState(() {
      _submitting = true;
    });

    try {
      var response = await CountryCommandCreate(CountryCreate()).execute(
        input['name']!.text,
        input['abbreviation']!.text,
        input['dialing_code']!.text,
      );

      if (response is ValidationResponse) {

        if (response.key['name'] != null) {
          setState(() {
            border['name'] = Colors.red;
            messages['name'] = response.message('name');
            input['name']!.clear();
          });
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              border['name'] = Colors.grey;
              messages['name'] = null;
            });
          });
        }

        if (response.key['abbreviation'] != null) {
          setState(() {
            border['abbreviation'] = Colors.red;
            messages['abbreviation'] = response.message('abbreviation');
            input['abbreviation']!.clear();
          });
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              border['abbreviation'] = Colors.grey;
              messages['abbreviation'] = null;
            });
          });
        }

        if (response.key['dialing_code'] != null) {
          setState(() {
            border['dialing_code'] = Colors.red;
            messages['dialing_code'] = response.message('dialing_code');
            input['dialing_code']!.clear();
          });
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              border['dialing_code'] = Colors.grey;
              messages['dialing_code'] = null;
            });
          });
        }
        
      } else {
        showDialog(
          context: context,
          builder: (context) => PopupWindow(
            title: response is SuccessResponse ? 'Success' 
                 : response is InternalServerError ? 'Error' 
                 : 'Error de Conexión',
            message: response.message,
          ),
        );
        input.forEach((key, controller) => controller.clear());
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => PopupWindow(
          title: 'Error',
          message: e.toString(),
        ),
      );
    } finally {
      setState(() {
        _submitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomInput(
              text: 'Name',
              input: input['name']!,
              border: border['name']!,
              error: messages['name'],
            ),
            SizedBox(height: 16.0),
            CustomInput(
              text: 'Abbreviation',
              input: input['abbreviation']!,
              border: border['abbreviation']!,
              error: messages['abbreviation'],
            ),
            SizedBox(height: 16.0),
            CustomInput(
              text: 'Dialing Code',
              input: input['dialing_code']!,
              border: border['dialing_code']!,
              error: messages['dialing_code'],
            ),
            SizedBox(height: 32.0),
            CustomButton(
              label: 'Submit',
              onPressed: _createCountry,
            ),
          ],
        ),
      ),
    );
  }
}
