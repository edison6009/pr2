import 'package:flutter/material.dart';
import 'package:pr2/Api/Command/CountryCommand.dart';
import 'package:pr2/Api/Model/CountryModel.dart';
import 'package:pr2/Api/Service/CountryService.dart';

class CountrySelector extends StatefulWidget {
  final ValueChanged<String?> onCountrySelected;

  CountrySelector({required this.onCountrySelected});

  @override
  _CountrySelectorState createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  List<Country> _countries = [];
  bool _isLoading = false;
  String? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _fetchData(); // Cargar datos al iniciar
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);

    try {
      final countryData = await CountryCommandIndex(CountryIndex()).execute();
      setState(() {
        _countries = countryData?.countries ?? [];
        _isLoading = false;
      });
    } catch (error) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    }
  }

  Future<void> _updateData() async {
    setState(() => _isLoading = true);

    try {
      final countryData = await CountryCommandIndex(CountryIndex()).execute();
      if (countryData != null) {
        setState(() {
          _countries = countryData.countries;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Datos actualizados')),
        );
      } else {
        throw Exception('No se pudo obtener los datos');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar: $error')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : DropdownButton<String>(
            value: _selectedCountry,
            hint: Text('Seleccione un país'),
            items: _countries.map((country) {
              return DropdownMenuItem<String>(
                value: country.dialingCode,
                child: Text('${country.name} (${country.dialingCode})'),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCountry = newValue;
              });
              widget.onCountrySelected(newValue);

              // Actualizar datos cuando se seleccione un país
              _updateData();
            },
          );
  }
}
