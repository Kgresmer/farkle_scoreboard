import 'package:farkle_scoreboard/widgets/scoreboard_player_list.dart';
import 'package:provider/provider.dart';
import '../models/RosterPlayer.dart';
import '../providers/roster.dart';
import '../widgets/score_input.dart';
import 'package:flutter/material.dart';

class ScoreboardScreen extends StatefulWidget {
  static const routeName = '/scoreboard';

  @override
  _ScoreboardScreenState createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  bool isGameComplete = false;

  void openScoreInput(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return GestureDetector(
            child: ScoreInput(),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final rosterData = Provider.of<Roster>(context);
    final List<RosterPlayer> _players = [...rosterData.players];
    _players.sort((a, b) => a.playOrder.compareTo(b.playOrder));

    RosterPlayer currentWinner = _players[0];
    bool allComplete = true;
    _players.forEach((p) => {
      if (p.score > currentWinner.score) currentWinner = p,
      if (!p.isComplete) {
        allComplete = false
      }
    });
    if (allComplete) {
      setState(() => {
        isGameComplete = true
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Farkle Scoreboard'),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return isGameComplete ? Text('Game Over!') : Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * .88,
              child: ScoreboardPlayerList(_players),
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

  static Route<Object> _dialogBuilder(
      BuildContext context, Object arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
      const AlertDialog(title: Text('Game Over!')),
    );
  }
}
