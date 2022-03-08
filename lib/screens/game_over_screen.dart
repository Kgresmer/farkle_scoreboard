import '../FileService.dart';
import '../models/ExistingPlayer.dart';
import '../providers/existing_players.dart';
import './fill_roster_screen.dart';
import 'package:provider/provider.dart';
import '../models/RosterPlayer.dart';
import '../providers/roster.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  static const routeName = '/gameover';

  @override
  Widget build(BuildContext context) {
    RosterPlayer winner =
        Provider.of<Roster>(context, listen: false).getWinner();
    List<ExistingPlayer> existingPlayers = Provider.of<ExistingPlayers>(context, listen: false).players.values.toList();
    existingPlayers.forEach((ep) => {
      if (ep.player.id == winner.player.id) {
        if (ep.player.bestScore < winner.score) {
          ep.player.bestScore = winner.score,
          ep.player.wins += 1
        }
      } else {
        ep.player.losses += 1
      }
    });
    FileService.writeContent([...existingPlayers.map((e) => e.player)]);
    Provider.of<Roster>(context, listen: false).restartGame();

    return Scaffold(
      appBar: AppBar(
        title: Text('Farkle Scoreboard'),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * .88,
              child: Center(
                  child: Container(
                      color: Theme.of(context).secondaryHeaderColor,
                      width: constraints.maxWidth * .70,
                      height: constraints.maxHeight * .40,
                      child: Center(
                          child: Text(
                        'Congratulations \n${winner.player.name}',
                        style: TextStyle(
                            fontSize: 30, color: Theme.of(context).cardColor),
                      )))),
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
                                backgroundColor: Theme.of(context).shadowColor,
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            onPressed: () => Navigator.of(ctx)
                                .pushNamed(FillRosterScreen.routeName),
                            child: Text('Continue',
                                style: TextStyle(
                                    color: Theme.of(context).canvasColor)))),
                  ]),
            ),
          ],
        );
      }),
    );
  }
}
