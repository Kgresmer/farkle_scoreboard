import 'package:flutter/material.dart';

class NewPlayer extends StatefulWidget {
  @override
  _NewPlayerState createState() => _NewPlayerState();
}

class _NewPlayerState extends State<NewPlayer> {
  final _nameController = TextEditingController();

  void _submitData() {
    final nameInput = _nameController.text;
    if (nameInput.isEmpty) return;

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 30,
              left: 10,
              right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                    labelText: 'Player Name:',
                    labelStyle: TextStyle(fontSize: 24, color: Colors.teal),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal))),
                controller: _nameController,
                autofocus: true,
                onSubmitted: (_) => _submitData(),
              ),
              RaisedButton(
                  child: Text(
                    'Add Player',
                    style: TextStyle(fontSize: 18),
                  ),
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  onPressed: _submitData)
            ],
          ),
        ),
      ),
    );
  }
}
