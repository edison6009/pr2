import 'package:flutter/material.dart';
import 'package:pr2/App/Widget/EditDialog.dart';

class Update extends StatefulWidget {
  final int id;

  Update({required this.id});

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late TextEditingController _nameController;
  late TextEditingController _capitalController;
  late TextEditingController _regionController;
  bool _nameSend = false;
  bool _capitalSend = false;
  bool _regionSend = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'no se, me sabe a webo');
    _capitalController = TextEditingController(text: 'no se, me sabe a webo');
    _regionController = TextEditingController(text: 'no se, me sabe a webo');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _capitalController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  void _editField(String field, TextEditingController controller,
      ValueChanged<String> onTextChanged, VoidCallback onSave) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDialog(
          field: field,
          controller: controller,
          onTextChanged: onTextChanged,
          onSave: onSave,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Country Details'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Name'),
            subtitle: Text(_nameController.text),
            onTap: () => _editField(
              'Name',
              _nameController,
              (text) => setState(() {
                _nameSend = text.isNotEmpty;
              }),
              () => setState(() {}),
            ),
          ),
          ListTile(
            title: Text('Capital'),
            subtitle: Text(_capitalController.text),
            onTap: () => _editField(
              'Capital',
              _capitalController,
              (text) => setState(() {
                _capitalSend = text.isNotEmpty;
              }),
              () => setState(() {}),
            ),
          ),
          ListTile(
            title: Text('Region'),
            subtitle: Text(_regionController.text),
            onTap: () => _editField(
              'Region',
              _regionController,
              (text) => setState(() {
                _regionSend = text.isNotEmpty;
              }),
              () => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }
}
