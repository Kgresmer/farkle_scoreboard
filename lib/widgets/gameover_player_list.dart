import 'package:provider/provider.dart';
import '../models/RosterPlayer.dart';
import 'package:flutter/material.dart';
import '../providers/roster.dart';

class GameOverPlayerList extends StatelessWidget {
  final RosterPlayer winner;

  GameOverPlayerList(this.winner);

  @override
  Widget build(BuildContext context) {
    final rosterData = Provider.of<Roster>(context);
    final List<RosterPlayer> _players = [...rosterData.players];
    _players.sort((a, b) => b.score.compareTo(a.score));

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 3,
          ),
          child: ListTile(
            tileColor: Theme.of(context).dividerColor,
            leading: Container(
              height: 30,
              child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: FittedBox(
                    child: Text(_players[index].player.name,
                        style: Theme.of(context).textTheme.headlineLarge),
                  )),
            ),
            title: Padding(
                padding: EdgeInsets.only(right: 25),
                child: Text(
                  _players[index].score.toString(),
                  style: Theme.of(context).textTheme.headlineLarge,
                )),
          ),
        );
      },
      itemCount: _players.length,
    );
  }
}
