import '../FileService.dart';
import '../models/ExistingPlayer.dart';
import '../providers/existing_players.dart';
import '../widgets/gameover_player_list.dart';
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
    print('init state game over');
    super.initState();
    RosterPlayer temp = Provider.of<Roster>(context, listen: false).getWinner();
    if (temp != null) {
      setState(() {
        winner = temp;
      });
    }
  }

  void backToRoster(BuildContext ctx) {
    print('back to roster');
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

  Future<bool> _backAPage(BuildContext context) async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    print('building game over');
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
                  child: Center(
                    child: Text(
                      'You crushed it $name!',
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
                                  backgroundColor: Theme.of(context).shadowColor,),
                              onPressed: () => backToRoster(context),
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
