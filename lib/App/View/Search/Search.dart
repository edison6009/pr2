import 'package:flutter/material.dart';
import 'package:pr2/App/Widget/CustomInput.dart';
import 'package:pr2/App/View/Index/Index.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _search = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();

    _search.addListener(() {
      setState(() {
        _searchText = _search.text;
      });
    });
  }

  @override
  void dispose() {
    _search.dispose();
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
              input: _search,
            ),
            Expanded(
              child: FutureBuilder(
                future: _fetchCountries(),
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
    if (_searchText.isEmpty) {
      return Center(child: Text(''));
    }
    return Index(
      name_: _searchText,
    );
  }
}

