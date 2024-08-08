import 'package:flutter/material.dart';
import 'package:pr2/Api/Command/CountryCommand.dart';
import 'package:pr2/Api/Service/CountryService.dart';
import 'package:pr2/Api/Response/ServiceResponse.dart';
import 'package:pr2/Api/Response/SuccessResponse.dart';
import 'package:pr2/Api/Response/InternalServerError.dart';
import 'package:pr2/Api/Response/ErrorResponse.dart';
import 'package:pr2/App/Widget/PopupWindow.dart';
import 'package:pr2/App/Widget/CustomInput.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _abbreviation = TextEditingController();
  final TextEditingController _dialingCode = TextEditingController();

  bool _submitting = false;

  Color _colorName = Colors.grey;
  String? _errorName;

  Future<void> _handleSubmit() async {
    setState(() {
      _submitting = true;
    });

    try {
      var response = await CountryCommandCreate(CountryCreate())
          .execute(_name.text, _abbreviation.text, _dialingCode.text);

      if (response is ValidationResponse) {
        if (response.key['name'] != null) {
          setState(() {
            _colorName = Colors.red;
            _errorName = response.message('name');
          });
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _colorName = Colors.grey;
              _errorName = null;
            });
          });
        }

      } else {
        showDialog(
          context: context,
          builder: (context) => PopupWindow(
            title: response is SuccessResponse ? 'Success' : 'Error',
            message: response is SuccessResponse
                ? response.message
                : response is SimpleErrorResponse
                    ? response.message
                    : response.message,
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

      _name.clear();
      _abbreviation.clear();
      _dialingCode.clear();
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
              hintText: 'Name',
              controller: _name,
              borderColor: _colorName,
              errorMessage: _errorName,
            ),
            SizedBox(height: 16.0),
            CustomInput(
              hintText: 'Abbreviation',
              controller: _abbreviation,
            ),
            SizedBox(height: 16.0),
            CustomInput(
              hintText: 'Dialing Code',
              controller: _dialingCode,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _submitting ? null : _handleSubmit,
              child: Text(_submitting ? 'Submit' : 'Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

