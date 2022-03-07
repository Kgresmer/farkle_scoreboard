import './fill_roster_screen.dart';
import 'package:provider/provider.dart';
import '../models/RosterPlayer.dart';
import '../providers/roster.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  static const routeName = '/gameover';

  @override
  Widget build(BuildContext context) {
    print('game over build');
    RosterPlayer winner = Provider.of<Roster>(context, listen: false).getWinner();
    Provider.of<Roster>(context, listen: false).restartGame();

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
              child: Text('Congratulations ${winner.player.name}'),
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
                            onPressed: () => Navigator.of(ctx).pushNamed(FillRosterScreen.routeName),
                            child: Text('Continue'))),
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
