import '../providers/roster.dart';
import '../models/ExistingPlayer.dart';
import '../models/RosterPlayer.dart';
import '../providers/existing_players.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ExistingPlayerList extends StatefulWidget {
  @override
  _ExistingPlayerListState createState() => _ExistingPlayerListState();
}

class _ExistingPlayerListState extends State<ExistingPlayerList> {
  void _showToast() {
    Fluttertoast.showToast(
        msg: "You hit the max player limit of 15",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).canvasColor,
        textColor: Theme.of(context).cardColor,
        fontSize: 16.0
    );
  }

  void selectPlayer(ExistingPlayer existingPlayer) {
    HapticFeedback.heavyImpact();
    if (Provider.of<Roster>(context, listen: false).players.length < 15 && !existingPlayer.selected) {
      setState(() {
        existingPlayer.selected = !existingPlayer.selected;
      });
      if (existingPlayer.selected) {
        Provider.of<Roster>(context, listen: false)
            .addPlayer(existingPlayer.player);
      }
    } else if (Provider.of<Roster>(context, listen: false).players.length == 15 && !existingPlayer.selected) {
      _showToast();
    } else {
      setState(() {
        existingPlayer.selected = !existingPlayer.selected;
      });
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
    RosterPlayer rosterPlayer;
    existingPlayers.forEach((ep) =>
    {
      rosterPlayer = rosterPlayers.firstWhere(
              (rp) => rp.player.id == ep.player.id,
          orElse: () => null),
      if (rosterPlayer != null)
        {ep.selected = true}
      else
        {ep.selected = false}
    });

    void removeExistingPlayer(ExistingPlayer existingPlayer) {
      showDialog(
        context: context,
        builder: (context) =>
        new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text(
              'Removing this player will erase them and all their history'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            TextButton(
              onPressed: () =>
              {
                Provider.of<ExistingPlayers>(context, listen: false)
                    .removePlayer(existingPlayer),
                Navigator.of(context).pop(false)
              },
              child: new Text('Yes'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          shadowColor: Colors.black,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(
              tileColor: Theme
                  .of(context)
                  .dividerColor,
              selectedTileColor: Theme
                  .of(context)
                  .shadowColor,
              selected: existingPlayers[index].selected,
              onTap: () => selectPlayer(existingPlayers[index]),
              isThreeLine: true,
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              leading: Container(
                height: double.infinity,
                child: CircleAvatar(
                    radius: 40,
                    backgroundColor: existingPlayers[index].player.color,
                    child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: FittedBox(
                          child: existingPlayers[index].selected
                              ? Icon(
                            Icons.check,
                            size: 40
                          )
                              : Text(
                              existingPlayers[index]
                                  .player
                                  .name
                                  .substring(0, 1),
                              style:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium),
                        ))),
              ),
              title: Text(
                existingPlayers[index].player.name,
                style: existingPlayers[index].selected
                    ? Theme
                    .of(context)
                    .textTheme
                    .bodyMedium
                    : Theme
                    .of(context)
                    .textTheme
                    .headlineLarge,
              ),
              subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        'Wins: ${existingPlayers[index].player
                            .wins} | Losses: ${existingPlayers[index].player
                            .losses}',
                        style: existingPlayers[index].selected
                            ? Theme
                            .of(context)
                            .textTheme
                            .bodySmall
                            : Theme
                            .of(context)
                            .textTheme
                            .headlineMedium),
                    Text(
                        'Best Score: ${existingPlayers[index].player
                            .bestScore}',
                        style: existingPlayers[index].selected
                            ? Theme
                            .of(context)
                            .textTheme
                            .bodySmall
                            : Theme
                            .of(context)
                            .textTheme
                            .headlineMedium),
                  ]),
              trailing: IconButton(
                icon: const Icon(
                  Icons.remove_circle_outline,
                ),
                iconSize: 45,
                color: Theme
                    .of(context)
                    .canvasColor,
                onPressed: () => removeExistingPlayer(existingPlayers[index]),
              )),
        );
      },
      itemCount: existingPlayers.length,
    );
  }
}
