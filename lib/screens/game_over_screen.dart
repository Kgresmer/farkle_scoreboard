import '../FileService.dart';
import '../models/ExistingPlayer.dart';
import '../providers/existing_players.dart';
import './fill_roster_screen.dart';
import 'package:provider/provider.dart';
import '../models/RosterPlayer.dart';
import '../providers/roster.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatefulWidget {
  static const routeName = '/gameover';

  @override
  _GameOverScreenState createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  RosterPlayer winner;

  @override
  void initState() {
    super.initState();
    print('init state game over');
    RosterPlayer temp = Provider.of<Roster>(context, listen: false).getWinner();
    if (temp != null) {
      setState(() {
        winner = temp;
      });
    }
  }

  void backToRoster(BuildContext ctx) {
    List<ExistingPlayer> existingPlayers =
    Provider.of<ExistingPlayers>(context, listen: false)
        .players
        .values
        .toList();
    existingPlayers.forEach((ep) => {
      if (ep.player.id == winner.player.id)
        {
          if (ep.player.bestScore < winner.score)
            {ep.player.bestScore = winner.score, ep.player.wins += 1}
        }
      else
        {ep.player.losses += 1}
    });
    FileService.writeContent([...existingPlayers.map((e) => e.player)]);
    Navigator.of(ctx).pushNamed(FillRosterScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    print('building game over screen');
    String name = (winner?.player?.name != null) ? winner.player.name : '';

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
                        'Congratulations \n${name}',
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
                            onPressed: () => backToRoster(context),
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
