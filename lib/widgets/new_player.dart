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
    Provider.of<ExistingPlayers>(context, listen: false)
        .addPlayer(new ExistingPlayer(player: newPlayer, selected: false));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          color: Theme.of(context).secondaryHeaderColor,
          padding: EdgeInsets.only(
              top: 25,
              bottom: MediaQuery.of(context).viewInsets.bottom + 30,
              left: 10,
              right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                autofocus: true,
                style: TextStyle(
                    height: 1.4,
                    decorationColor: Theme.of(context).secondaryHeaderColor,
                    color: Theme.of(context).cardColor,
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
                cursorColor: Theme.of(context).cardColor,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 3),
                    labelText: 'Player Name:',
                    icon: Icon(
                      Icons.account_circle,
                      size: 45,
                      color: Theme.of(context).shadowColor,
                    ),
                    labelStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).cardColor,
                        height: 0.3),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).cardColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).cardColor))),
                controller: _nameController,
                onSubmitted: (_) => _submitData(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: ElevatedButton(
                    child: Text(
                      'Add Player',
                      style: TextStyle(fontSize: 19),
                    ),
                    onPressed: _submitData),
              )
            ],
          ),
        ),
      ),
    );
  }
}
