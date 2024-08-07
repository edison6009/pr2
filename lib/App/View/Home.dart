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

  Color _nameBorderColor = Colors.grey;
  // Color _abbreviationBorderColor = Colors.grey;

  Future<void> _handleSubmit() async {
    try {
      var response = await CountryCommandCreate(CountryCreate())
          .execute(_name.text, _abbreviation.text, _dialingCode.text);

    if (response is ValidationResponse) {
          var names = response.validation()[0];

        if (names.contains('name')) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _nameBorderColor = Colors.red;
            });
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _nameBorderColor = Colors.grey;
              });
            });
          });
        }

        // if (names.contains('abbreviation')) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     setState(() {
        //       _abbreviationBorderColor = Colors.red;
        //     });
        //     Future.delayed(Duration(seconds: 2), () {
        //       setState(() {
        //         _abbreviationBorderColor = Colors.grey;
        //       });
        //     });
        //   });
        // }
      } else {
        showDialog(
          context: context,
          builder: (context) => PopupWindow(
            title: response is SuccessResponse ? 'Success' : 'Error',
            message
            : response is SuccessResponse ? response.message
            : response is SimpleErrorResponse ? response.message
            : response.title,
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
              borderColor: _nameBorderColor,
            ),
            SizedBox(height: 16.0),
            CustomInput(
              hintText: 'Abbreviation',
              controller: _abbreviation,
              // borderColor: _abbreviationBorderColor,
            ),
            SizedBox(height: 16.0),
            CustomInput(
              hintText: 'Dialing Code',
              controller: _dialingCode,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
