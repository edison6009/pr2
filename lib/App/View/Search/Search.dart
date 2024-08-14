import 'package:flutter/material.dart';
import 'package:pr2/App/Widget/CustomInput.dart';
import 'package:pr2/App/View/Index/Index.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomInput(
              text: 'Search',
              input: _searchController,
            ),
            Expanded(
              child: FutureBuilder(
                future:
                    _fetchCountries(), // Llama a la función que crea el widget Index
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return snapshot.data as Widget;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Widget> _fetchCountries() async {
    // Retorna el widget Index con el texto actual de búsqueda
    return Index(
      name_: _searchText,
    );
  }
}
