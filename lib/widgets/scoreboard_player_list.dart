import 'package:provider/provider.dart';
import '../models/RosterPlayer.dart';
import 'package:flutter/material.dart';
import '../providers/roster.dart';
import '../screens/game_over_screen.dart';

class ScoreboardPlayerList extends StatelessWidget {

  renderFarkles(BuildContext context, int numOfFarkles) {
    List<Widget> farkles = [];
    for (int i = 0; i < numOfFarkles; i++) {
      farkles.add(CircleAvatar(
          radius: 15,
          backgroundColor: Theme.of(context).canvasColor,
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('F',
                    style: Theme.of(context).textTheme.bodyMedium),
              ))));
    }
    return Padding(padding: EdgeInsets.only(right: 15), child: Row(children: <Widget>[...farkles]));
  }

  void evaluateIfGameIsOver(context) {
    final rosterData = Provider.of<Roster>(context, listen: false);
    final List<RosterPlayer> _players = [...rosterData.players];
    if (_players.length > 0) {
      RosterPlayer currentWinner = _players[0];
      bool allComplete = true;
      _players.forEach((p) =>
      {
        if (p.score > currentWinner.score) currentWinner = p,
        if (!p.isComplete) {allComplete = false}
      });
      if (allComplete) {
        Navigator.of(context).pushNamed(GameOverScreen.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => evaluateIfGameIsOver(context));
    final rosterData = Provider.of<Roster>(context);
    final List<RosterPlayer> _players = [...rosterData.players];
    _players.sort((a, b) => a.playOrder.compareTo(b.playOrder));

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 5,
          ),
          child: ListTile(
            selectedTileColor: Theme.of(context).shadowColor,
            tileColor: _players[index].isComplete ? Colors.black38 : Theme.of(context).dividerColor,
            selected: _players[index].active,
            contentPadding: EdgeInsets.symmetric(vertical: 2),
            leading: Container(
              height: 30,
              child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: FittedBox(
                    child: Text(_players[index].player.name,
                        style: _players[index].active ? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.headlineLarge),
                  )),
            ),
            title: Padding(
              padding: EdgeInsets.only(right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  renderFarkles(
                      context, _players[index].farkles),
                  Text(
                    _players[index].score.toString(),
                    style: _players[index].active ? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.headlineLarge,
                  )
                ],
              ),
            ),
          ),
        );
      },
      itemCount: _players.length,
    );
  }
}