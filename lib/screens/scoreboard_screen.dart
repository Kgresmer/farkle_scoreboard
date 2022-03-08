import 'package:farkle_scoreboard/screens/fill_roster_screen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/roster.dart';
import '../widgets/scoreboard_player_list.dart';
import '../widgets/score_input.dart';
import 'package:flutter/material.dart';

class ScoreboardScreen extends StatefulWidget {
  static const routeName = '/scoreboard';

  @override
  _ScoreboardScreenState createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
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

  Future<bool> _backAPage(BuildContext context) async {
    HapticFeedback.heavyImpact();
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit this game? The score will reset.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed(FillRosterScreen.routeName),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    Provider.of<Roster>(context, listen: false).restartGame();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () => _backAPage(context),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => _backAPage(context),
            ),
            title: Text('Farkle Scoreboard',
                style: TextStyle(color: Theme.of(context).cardColor)),
          ),
          body: LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * .88,
                  child: ScoreboardPlayerList(),
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
                                    backgroundColor:
                                        Theme.of(context).shadowColor,
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () => openScoreInput(context),
                                child: Text('Begin scoring',
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).canvasColor)))),
                      ]),
                ),
              ],
            );
          }),
        ));
  }
}
