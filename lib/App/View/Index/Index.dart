import 'package:flutter/material.dart';
import 'package:pr2/Api/Model/CountryModel.dart';
import 'package:pr2/Api/Command/CountryCommand.dart';
import 'package:pr2/Api/Response/InternalServerError.dart';
import 'package:pr2/App/Widget/CustomButton.dart';
import 'package:pr2/App/Widget/CountryListView.dart';
import 'package:pr2/App/Widget/PopupWindow.dart';
import 'package:pr2/Api/Service/CountryService.dart';
import 'package:pr2/Api/Response/ErrorResponse.dart';

class Index extends StatefulWidget {
  final String? name_;
  int page = 1;

  Index({this.name_});

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final filters = {
    'pag=': '10',
    'page=': null,
    'name=': null,
  };

  List<Country> countries = [];
  late ScrollController _scrollController;
  bool _isLoading = false;
  bool _hasMorePages = true;

  Future<void> fetchCountries() async {
    if (_isLoading || !_hasMorePages) return;

    _isLoading = true;

    if (widget.name_?.isNotEmpty ?? false) {
      filters['name='] = widget.name_;
    }

    filters['page='] = widget.page.toString();

    final countryCommand = CountryCommandIndex(CountryIndex(), filters);

    try {
      var response = await countryCommand.execute();

      if (response is CountryModel) {
        setState(() {
          countries.addAll(response.results.countries);
          _hasMorePages = response.next != null;
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
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => PopupWindow(
          title: 'Error',
          message: e.toString(),
        ),
      );
    } finally {
      _isLoading = false;
    }
  }

  void reloadView() {
    setState(() {
      widget.page = 1;
      countries.clear();
      _hasMorePages = true;
    });
    fetchCountries();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            widget.page++;
            fetchCountries();
          });
        }
      });
    fetchCountries();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Index')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            CustomButton(label: 'Recargar Vista', onPressed: reloadView),
            SizedBox(height: 20),
            CountryListView(
                countries: countries, scrollController: _scrollController),
          ],
        ),
      ),
    );
  }
}
