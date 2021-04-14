import './fill_roster_screen.dart';
import '../models/Player.dart';
import '../models/ExistingPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExistingPlayerScreen extends StatefulWidget {
  static const routeName = '/add-existing-player';

  @override
  _AddExistingPlayerScreenState createState() => _AddExistingPlayerScreenState();
}

class _AddExistingPlayerScreenState extends State<AddExistingPlayerScreen> {

  void backToFillYourRoster(BuildContext ctx) {
    HapticFeedback.heavyImpact();
    Navigator.of(ctx).pushNamed(FillRosterScreen.routeName);
  }

  List<ExistingPlayer> _existingPlayers = [
    ExistingPlayer(player: Player(name: 'Kevin',
        color: 1,
        wins: 5,
        losses: 1,
        bestScore: 10200), selected: false),
    ExistingPlayer(player: Player(name: 'Sigrid',
        color: 2,
        wins: 1,
        losses: 5,
        bestScore: 9900), selected: false),
    ExistingPlayer(player: Player(name: 'Sigrid',
        color: 2,
        wins: 1,
        losses: 5,
        bestScore: 9900), selected: false),
    ExistingPlayer(player: Player(name: 'Sigrid',
        color: 2,
        wins: 1,
        losses: 5,
        bestScore: 9900), selected: false),
    ExistingPlayer(player: Player(name: 'Sigrid',
        color: 2,
        wins: 1,
        losses: 5,
        bestScore: 9900), selected: false),
    ExistingPlayer(player: Player(name: 'Sigrid',
        color: 2,
        wins: 1,
        losses: 5,
        bestScore: 9900), selected: false),
    ExistingPlayer(player: Player(name: 'Sigrid',
        color: 2,
        wins: 1,
        losses: 5,
        bestScore: 9900), selected: false),
  ];

  void selectPlayer(int index) {
    HapticFeedback.heavyImpact();
    setState(() {
      _existingPlayers[index].selected = !_existingPlayers[index].selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Add Existing Players'),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
                height: constraints.maxHeight * .04,
                child: Center(
                  child: Text('click player card(s) to add to roster',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2),)
            ),
            Container(
              height: constraints.maxHeight * .84,
              child: ListView.builder(
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
                      selected: _existingPlayers[index].selected,
                      onTap: () => selectPlayer(index),
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
                                      _existingPlayers[index].player.name.substring(
                                          0, 1),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1),
                                ))),
                      ),
                      title: Text(
                        _existingPlayers[index].player.name,
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
                                'Wins: ${_existingPlayers[index].player
                                    .wins} | Losses: ${_existingPlayers[index].player
                                    .losses}',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline5),
                            Text('Best Score: ${_existingPlayers[index].player
                                .bestScore}',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline5),
                          ]),
                    ),
                  );
                },
                itemCount: _existingPlayers.length,
              ),
            ),
            Container(
              height: constraints.maxHeight * .12,
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        height: constraints.maxHeight * .09,
                        width: constraints.maxWidth - 25,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            onPressed: () => backToFillYourRoster(context),
                            child: Text('Done'))),
                  ]),
            ),
          ],
        );
      }),
    );
  }
}
