import 'package:flutter/material.dart';
import 'package:pr2/Api/Command/CountryCommand.dart';
import 'package:pr2/Api/Service/CountryService.dart';
import 'package:pr2/Api/Response/ServiceResponse.dart';
import 'package:pr2/Api/Response/SuccessResponse.dart';
import 'package:pr2/Api/Response/InternalServerError.dart';
import 'package:pr2/Api/Response/ErrorResponse.dart';
import 'package:pr2/App/Widget/PopupWindow.dart';
import 'package:pr2/App/Widget/CustomInput.dart';
import 'Fields.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _submitting = false;

  Future<void> _call() async {
    setState(() {
      _submitting = true;
    });

    try {
      var response = await CountryCommandCreate(CountryCreate()).execute
      (
        input['name']!.text,
        input['abbreviation']!.text,
        input['dialingCode']!.text,
      );

      if (response is ValidationResponse) {

        if (response.key['name'] != null) {
          setState(() {
            border['name'] = Colors.red;
            messages['name'] = response.message('name');
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
            title: response is SuccessResponse 
                 ? 'Success' 
                 : 'Error',
          message: response.message,
          ),
        );
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

      input.forEach((key, controller) => controller.clear());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
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
              input: input['dialingCode']!,
              border: border['dialing_code']!,
              error: messages['dialing_code'],
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _submitting ? null : _call,
              child: Text(_submitting ? 'Submit' : 'Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
