import 'package:farkle_scoreboard/models/RosterPlayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/roster.dart';

class RosterPlayerList extends StatefulWidget {
  final List<RosterPlayer> rosterPlayers;

  RosterPlayerList(this.rosterPlayers);

  @override
  _RosterPlayerListState createState() => _RosterPlayerListState();
}

class _RosterPlayerListState extends State<RosterPlayerList> {
  void removePlayerFromRoster(context, player) {
    Provider.of<Roster>(context, listen: false).removePlayer(player);
  }

  @override
  Widget build(BuildContext context) {
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
            tileColor: Theme.of(context).dividerColor,
            isThreeLine: false,
            contentPadding: EdgeInsets.symmetric(vertical: 5),
            leading: Container(
              height: double.infinity,
              child: CircleAvatar(
                  radius: 40,
                  backgroundColor: widget.rosterPlayers[index].player.color,
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                            widget.rosterPlayers[index].player.name
                                .substring(0, 1),
                            style: Theme.of(context).textTheme.bodyMedium),
                      ))),
            ),
            title: Text(
              widget.rosterPlayers[index].player.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            subtitle: Text(
                'Wins: ${widget.rosterPlayers[index].player.wins} | Losses: ${widget.rosterPlayers[index].player.losses}',
                style: Theme.of(context).textTheme.headlineMedium),
            trailing: IconButton(
              icon: const Icon(
                Icons.remove_circle_outline,
              ),
              iconSize: 45,
              color: Theme.of(context).canvasColor,
              onPressed: () => removePlayerFromRoster(
                  context, widget.rosterPlayers[index].player),
            ),
          ),
        );
      },
      itemCount: widget.rosterPlayers.length,
    );
  }
}
