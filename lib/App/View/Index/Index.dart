import 'package:flutter/material.dart';
import 'package:pr2/Api/Model/CountryModels.dart';
import 'package:pr2/Api/Command/CountryCommand.dart';
import 'package:pr2/Api/Response/InternalServerError.dart';
import 'package:pr2/App/Widget/CustomButton.dart';
import 'package:pr2/App/Widget/CountriesListView.dart';
import 'package:pr2/App/Widget/PopupWindow.dart';
import 'package:pr2/Api/Service/CountryService.dart';
import 'package:pr2/Api/Response/ErrorResponse.dart';

class Index extends StatefulWidget {
  String? name_;
  int page_ = 1;

  Index({this.name_});

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {

  List<Country> countries = [];
  late ScrollController _scrollController;
  bool _isLoading = false;
  bool _hasMorePage_s = true;

  final filters = {
    'pag=': '10',
    'page=': null,
    'name=': null,
  };

  Future<void> _callCountries () async {
    if (_isLoading || !_hasMorePage_s) return;

    _isLoading = true;

    if (widget.name_?.isNotEmpty ?? false) {
      filters['name='] = widget.name_;
    }

    filters['page='] = widget.page_.toString();

    final countryCommand = CountryCommandIndex(CountryIndex(), filters);

    try {
      var response = await countryCommand.execute();

      if (mounted) {
        if (response is CountriesModel) {
          setState(() {
            countries.addAll(response.results.countries);
            _hasMorePage_s = response.next != null;
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
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void reloadView() {
    setState(() {
      widget.page_ = 1;
      countries.clear();
      _hasMorePage_s = true;
    });
    _callCountries ();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            widget.page_++;
            _callCountries ();
          });
        }
      });
    _callCountries ();
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
            CountriesListView(
                countries: countries, scrollController: _scrollController),
          ],
        ),
      ),
    );
  }
}
