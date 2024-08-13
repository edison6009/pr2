// lib/App/Widget/CountryListView.dart
import 'package:flutter/material.dart';
import 'package:pr2/Api/Model/CountryModel.dart';

class CountryListView extends StatefulWidget {
  final List<Country> countries;
  final ScrollController scrollController; // Recibe el controlador de scroll

  CountryListView({required this.countries, required this.scrollController});

  @override
  _CountryListViewState createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
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
