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
import 'package:pr2/App/Widget/CustomLabel.dart';
import 'package:pr2/Api/Model/CountryModels.dart';

class Update extends StatefulWidget {
  final int id;

  Update({required this.id});

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  CountryModel? _country;
  bool _submitting = false;

  final input = {
    'name': TextEditingController(),
    'abbreviation': TextEditingController(),
    'dialing_code': TextEditingController(),
  };

  Future<void> _callCountry() async {
    final countryCommand = CountryCommandShow(CountryShow(), widget.id);

    try {
      final response = await countryCommand.execute();

      if (mounted) {
        if (response is CountryModel) {
          setState(() {
            _country = response;
            input['name']!.text = _country!.name;
            input['abbreviation']!.text = _country!.abbreviation;
            input['dialing_code']!.text = _country!.dialingCode;
          });
        } else {
          showDialog(
            context: context,
            builder: (context) => PopupWindow(
              title: response is InternalServerError
                  ? 'Error'
                  : 'Error de Conexión',
              message: response.message,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => PopupWindow(
            title: 'Error',
            message: e.toString(),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _callCountry();
  }

  void reloadView() {
      setState(() {
        _country = null;
        input.forEach((key, controller) => controller.clear());
      });
      _callCountry();
  }

    Future<void> _createCountry() async {
    setState(() {
      _submitting = true;
    });

    try {
      var response = await CountryCommandUpdate(CountryUpdate()).execute(
        input['name']!.text,
        input['abbreviation']!.text,
        input['dialing_code']!.text,
        widget.id
      );

      showDialog(
        context: context,
        builder: (context) => PopupWindow(
          title: response is SuccessResponse
              ? 'Success'
              : response is InternalServerError
                  ? 'Error'
                  : 'Error de Conexión',
          message: response.message,
        ),
      );
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
    final border = {
      'name': Colors.grey,
      'abbreviation': Colors.grey,
      'dialing_code': Colors.grey
    };

    final messages = {
      'name': null,
      'abbreviation': null,
      'dialing_code': null,
    };

    return Scaffold(
      appBar: AppBar(title: Text('Update Country')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabel(text: 'Name'),
            SizedBox(height: 4.0),
            CustomInput(
              input: input['name']!,
              border: border['name']!,
            ),
            SizedBox(height: 16.0),
            CustomLabel(text: 'Abbreviation'),
            SizedBox(height: 4.0),
            CustomInput(
              input: input['abbreviation']!,
              border: border['abbreviation']!,
            ),
            SizedBox(height: 16.0),
            CustomLabel(text: 'Dialing Code'),
            SizedBox(height: 4.0),
            CustomInput(
              input: input['dialing_code']!,
              border: border['dialing_code']!,
            ),
            SizedBox(height: 32.0),
            CustomButton(
              label: 'Submit',
              onPressed: () {
                _createCountry();
              },
            ),
          ],
        ),
      ),
    );
  }
}
