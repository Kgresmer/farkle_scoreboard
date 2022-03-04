import '../models/RosterPlayer.dart';
import 'package:flutter/material.dart';

class ScoreboardPlayerList extends StatelessWidget {
  final List<RosterPlayer> _players;

  ScoreboardPlayerList(this._players);

  renderFarkles(BuildContext context, int numOfFarkles) {
    List<Widget> farkles = [];
    for (int i = 0; i < numOfFarkles; i++) {
      farkles.add(CircleAvatar(
          radius: 15,
          backgroundColor: Colors.black,
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('F',
                    style: Theme.of(context).textTheme.bodyText1),
              ))));
    }
    return Padding(padding: EdgeInsets.only(right: 15), child: Row(children: <Widget>[...farkles]));
  }

  @override
  Widget build(BuildContext context) {

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
            selectedTileColor: Colors.deepOrange,
            tileColor: _players[index].isComplete ? Colors.black38 : Colors.teal,
            selected: _players[index].active,
            contentPadding: EdgeInsets.symmetric(vertical: 2),
            leading: Container(
              height: 30,
              child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: FittedBox(
                    child: Text(_players[index].player.name,
                        style: Theme.of(context).textTheme.bodyText1),
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
                    style: Theme.of(context).textTheme.headline4,
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