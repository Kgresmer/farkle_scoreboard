import 'package:farkle_scoreboard/models/ExistingPlayer.dart';
import 'package:farkle_scoreboard/providers/existing_players.dart';

import '../models/Player.dart';
import '../providers/roster.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPlayer extends StatefulWidget {
  @override
  _NewPlayerState createState() => _NewPlayerState();
}

class _NewPlayerState extends State<NewPlayer> {
  final _nameController = TextEditingController();

  void _submitData() {
    final nameInput = _nameController.text;
    if (nameInput.isEmpty) return;
    var newPlayer = new Player(name: nameInput, color: 1);

    Provider.of<Roster>(context, listen: false).addPlayer(newPlayer);
    Provider.of<ExistingPlayers>(context, listen: false).addPlayer(new ExistingPlayer(player: newPlayer, selected: false));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 25,
              bottom: MediaQuery.of(context).viewInsets.bottom + 30,
              left: 10,
              right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                    labelText: 'Player Name:',
                    icon: Icon(
                      Icons.account_circle,
                      size: 35,
                      color: Colors.teal,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.teal,
                      height: 0.2
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal))),
                controller: _nameController,
                autofocus: true,
                onSubmitted: (_) => _submitData(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: RaisedButton(
                    child: Text(
                      'Add Player',
                      style: TextStyle(fontSize: 18),
                    ),
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    onPressed: _submitData),
              )
            ],
          ),
        ),
      ),
    );
  }
}
