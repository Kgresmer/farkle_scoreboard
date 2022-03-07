import 'package:farkle_scoreboard/providers/roster.dart';

import '../models/ExistingPlayer.dart';
import '../models/RosterPlayer.dart';
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
      Provider.of<Roster>(context, listen: false)
          .addPlayer(existingPlayer.player);
    } else {
      Provider.of<Roster>(context, listen: false)
          .removePlayer(existingPlayer.player);
    }
  }

  @override
  Widget build(BuildContext context) {
    final existingPlayersData = Provider.of<ExistingPlayers>(context);
    final existingPlayers = existingPlayersData.players.values.toList();
    final rosterPlayersData = Provider.of<Roster>(context);
    final rosterPlayers = rosterPlayersData.players;
    print(rosterPlayers.length);
    RosterPlayer rosterPlayer = null;
    existingPlayers.forEach((ep) => {
          rosterPlayer = rosterPlayers.firstWhere(
              (rp) => rp.player.id == ep.player.id,
              orElse: () => null),
          if (rosterPlayer != null) {
            ep.selected = true
          } else {
            ep.selected = false
          }
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
            tileColor: Theme.of(context).dividerColor,
            selectedTileColor: Theme.of(context).shadowColor,
            selected: existingPlayers[index].selected,
            onTap: () => selectPlayer(existingPlayers[index]),
            isThreeLine: true,
            contentPadding: EdgeInsets.symmetric(vertical: 5),
            leading: Container(
              height: double.infinity,
              child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context).shadowColor,
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: existingPlayers[index].selected
                            ? Icon(
                                Icons.check,
                                size: 40,
                              )
                            : Text(
                                existingPlayers[index]
                                    .player
                                    .name
                                    .substring(0, 1),
                                style: Theme.of(context).textTheme.titleLarge),
                      ))),
            ),
            title: Text(
              existingPlayers[index].player.name,
              style: existingPlayers[index].selected
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.headlineLarge,
            ),
            subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      'Wins: ${existingPlayers[index].player.wins} | Losses: ${existingPlayers[index].player.losses}',
                      style: existingPlayers[index].selected
                          ? Theme.of(context).textTheme.bodySmall
                          : Theme.of(context).textTheme.headlineMedium),
                  Text('Best Score: ${existingPlayers[index].player.bestScore}',
                      style: existingPlayers[index].selected
                          ? Theme.of(context).textTheme.bodySmall
                          : Theme.of(context).textTheme.headlineMedium),
                ]),
          ),
        );
      },
      itemCount: existingPlayers.length,
    );
  }
}
