import '../widgets/score_input.dart';
import '../models/PlayerScore.dart';
import '../models/Player.dart';
import 'package:flutter/material.dart';

class ScoreboardScreen extends StatefulWidget {
  static const routeName = '/scoreboard';

  @override
  _ScoreboardScreenState createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  List<PlayerScore> _players = [
    PlayerScore(
        player: Player(
            name: 'Kevin', color: 1, wins: 5, losses: 1, bestScore: 10200),
        active: true,
        currentScore: 0,
        previousScore: 0,
        numOfFarkles: 0),
    PlayerScore(
        player: Player(
            name: 'Sigrid', color: 1, wins: 5, losses: 1, bestScore: 10200),
        active: false,
        currentScore: 50,
        previousScore: 2500,
        numOfFarkles: 3),
    PlayerScore(
        player: Player(
            name: 'George', color: 1, wins: 5, losses: 1, bestScore: 10200),
        active: false,
        currentScore: 5450,
        previousScore: 4200,
        numOfFarkles: 1),
    PlayerScore(
        player: Player(
            name: 'Fred', color: 1, wins: 5, losses: 1, bestScore: 10200),
        active: false,
        currentScore: 10550,
        previousScore: 8700,
        numOfFarkles: 2),
  ];

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

  void updateScore(int playerIndex, int score, bool farkle) {

  }

  void openScoreInput(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return GestureDetector(
            onTap: () => updateScore(1, 1500, false),
            child: ScoreInput(),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Farkle Scoreboard'),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * .88,
              child: ListView.builder(
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
                      tileColor: Colors.teal,
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
                                context, _players[index].numOfFarkles),
                            Text(
                              _players[index].currentScore.toString(),
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _players.length,
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
                            onPressed: () => openScoreInput(context),
                            child: Text('Score'))),
                  ]),
            ),
          ],
        );
      }),
    );
  }
}
