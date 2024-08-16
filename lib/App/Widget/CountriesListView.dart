// lib/App/Widget/CountriesListView.dart
import 'package:flutter/material.dart';
import 'package:pr2/Api/Model/CountryModels.dart';

class CountriesListView extends StatefulWidget {
  final List<Country> countries;
  final ScrollController scrollController;

  CountriesListView({required this.countries, required this.scrollController});

  @override
  _CountriesListViewState createState() => _CountriesListViewState();
}

class _CountriesListViewState extends State<CountriesListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: widget.scrollController, // Usa el controlador recibido
        itemCount: widget.countries.length,
        itemBuilder: (context, index) {
          final country = widget.countries[index];
          return ListTile(
            title: Text(country.name),
            subtitle: Text('${country.abbreviation}, ${country.dialingCode}'),
          );
        },
      ),
    );
  }
}
