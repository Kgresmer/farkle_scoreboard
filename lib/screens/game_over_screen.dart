import 'package:farkle_scoreboard/screens/landing_screen.dart';

import '../FileService.dart';
import '../models/ExistingPlayer.dart';
import '../providers/existing_players.dart';
import '../widgets/gameover_player_list.dart';
import './fill_roster_screen.dart';
import 'package:provider/provider.dart';
import '../models/RosterPlayer.dart';
import '../providers/roster.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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
    RosterPlayer temp = Provider.of<Roster>(context, listen: false).getWinner();
    if (temp != null) {
      setState(() {
        winner = temp;
      });
    }
  }

  void backToHome(BuildContext ctx) {
    List<RosterPlayer> rps =
        Provider.of<Roster>(context, listen: false).players;
    List<ExistingPlayer> existingPlayers =
        Provider.of<ExistingPlayers>(context, listen: false)
            .players
            .values
            .toList();
    existingPlayers.forEach((ep) => {
          if (ep.player.id == winner.player.id)
            {ep.player.wins += 1}
          else
            {ep.player.losses += 1},
          if (ep.player.highestRoll <
              rps
                  .singleWhere((r) => r.player.id == ep.player.id)
                  .player
                  .highestRoll)
            ep.player.highestRoll = rps
                .singleWhere((r) => r.player.id == ep.player.id)
                .player
                .highestRoll
        });
    FileService.writeContent([...existingPlayers.map((e) => e.player)]);
    Navigator.of(ctx).pushNamed(LandingScreen.routeName);
  }

  Future<bool> _backAPage(BuildContext context) async {
    return false;
  }

  String getGameOverBanner(String name) {
    int index = 1 + Random().nextInt(8 - 1);
    switch (index) {
      case 1: return '$name played marvelously!';
      case 2: return 'You crushed it $name!';
      case 3: return 'You got pretty lucky there $name';
      case 4: return '$name is making their mark on the map!';
      case 5: return '$name is dancing with the stars!';
      case 6: return '$name struck gold!';
      case 7: return 'Nice risk management $name';
      case 7: return 'Looking good $name!';
      default: return 'You crushed it $name!';
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = (winner?.player?.name != null) ? winner.player.name : '';

    return WillPopScope(
      onWillPop: () => _backAPage(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Farkle Scoreboard'),
        ),
        body: LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            children: <Widget>[
              Container(
                  height: constraints.maxHeight * .12,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: Text(
                      getGameOverBanner(name),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  )),
              Container(
                  height: constraints.maxHeight * .76,
                  child: GameOverPlayerList(winner)),
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
                              ),
                              onPressed: () => backToHome(context),
                              child: Text('Back to home',
                                  style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold)))),
                    ]),
              ),
            ],
          );
        }),
      ),
    );
  }
}
