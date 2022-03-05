import 'package:farkle_scoreboard/providers/roster.dart';

import '../models/ExistingPlayer.dart';
import '../providers/existing_players.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ExistingPlayerList extends StatefulWidget {

  @override
  _ExistingPlayerListState createState() => _ExistingPlayerListState();
}

class _ExistingPlayerListState extends State<ExistingPlayerList> {

  void selectPlayer(ExistingPlayer existingPlayer) {
    HapticFeedback.heavyImpact();
    setState(() {
      existingPlayer.selected = !existingPlayer.selected;
    });
    if (existingPlayer.selected) {
      Provider.of<Roster>(context, listen: false).addPlayer(existingPlayer.player);
    } else {
      Provider.of<Roster>(context, listen: false).removePlayer(existingPlayer.player);
    }
  }

  @override
  Widget build(BuildContext context) {
    final existingPlayersData = Provider.of<ExistingPlayers>(context);
    final existingPlayers = existingPlayersData.players.values.toList();
    final rosterPlayersData = Provider.of<Roster>(context);
    final rosterPlayers = rosterPlayersData.players;
    ExistingPlayer ep = null;
    rosterPlayers.forEach((rp) => {
      ep = existingPlayers.firstWhere((exp) => exp.player.id == rp.player.id,
          orElse: () => null),
      if (ep != null) ep.selected = true
    });

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(
            tileColor: Colors.white,
            selectedTileColor: Colors.orange,
            selected: existingPlayers[index].selected,
            onTap: () => selectPlayer(existingPlayers[index]),
            isThreeLine: true,
            contentPadding: EdgeInsets.symmetric(vertical: 5),
            leading: Container(
              height: double.infinity,
              child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.teal,
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                            existingPlayers[index].player.name.substring(
                                0, 1),
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1),
                      ))),
            ),
            title: Text(
              existingPlayers[index].player.name,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6,
            ),
            subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      'Wins: ${existingPlayers[index].player
                          .wins} | Losses: ${existingPlayers[index].player
                          .losses}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5),
                  Text('Best Score: ${existingPlayers[index].player
                      .bestScore}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5),
                ]),
          ),
        );
      },
      itemCount: existingPlayers.length,
    );
  }
}