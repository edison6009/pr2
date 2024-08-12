// lib/App/Widget/CountryListView.dart
import 'package:flutter/material.dart';
import 'package:pr2/Api/Model/CountryModel.dart';

class CountryListView extends StatefulWidget {
  final List<Country> countries;

  CountryListView({required this.countries});

  @override
  _CountryListViewState createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          print('Llegaste al final');
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
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
