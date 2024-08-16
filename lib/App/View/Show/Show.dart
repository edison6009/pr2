import 'package:flutter/material.dart';
import 'package:pr2/Api/Command/CountryCommand.dart';
import 'package:pr2/Api/Service/CountryService.dart';
import 'package:pr2/Api/Response/ServiceResponse.dart';
import 'package:pr2/Api/Response/SuccessResponse.dart';
import 'package:pr2/Api/Response/InternalServerError.dart';
import 'package:pr2/Api/Response/ErrorResponse.dart';
import 'package:pr2/App/Widget/PopupWindow.dart';
import 'package:pr2/Api/Model/CountryModels.dart';

class Show extends StatefulWidget {
  final int id;

  Show({required this.id});

  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  CountryModel? _country;

  @override
  void initState() {
    super.initState();
    _callCountry();
  }

  Future<void> _callCountry() async {
    final countryCommand = CountryCommandShow(CountryShow(), widget.id);

    try {
      final response = await countryCommand.execute();

      if (mounted) {
        if (response is CountryModel) {
          setState(() {
            _country = response;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Country Details'),
      ),
      body: _country == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(_country!.name),
                ),
                ListTile(
                  title: Text('Capital'),
                  subtitle: Text(_country!.abbreviation),
                ),
                ListTile(
                  title: Text('Region'),
                  subtitle: Text(_country!.dialingCode),
                ),
              ],
            ),
    );
  }
}
