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
            content: new Text(
                'Do you want to exit this game? The score will reset.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(FillRosterScreen.routeName),
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    Provider.of<Roster>(context, listen: false).restartGame();
  }

  showRulesModal(BuildContext context, double height, double width) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Rules'),
            content: Container(
                height: height,
                width: width,
                child: SingleChildScrollView(
                    child: Text(
                        'To win at Farkle you must be the player with the highest score above 10,000 points on the final round of play. \n\nEach player takes turns rolling the dice. On your turn, you roll all six dice. A single 1 or a 5, three of a kind, four of a kind, five of a kind, six of a kind, three pairs, two triples, a pair and four of a kind together, or a six-dice straight earn points. You must select at least one scoring die. You can pass and bank your points, or risk the points earned this turn and roll the remaining dice. \n\nScoring is based on selected dice in each roll. You cannot earn points by combining dice from different rolls. \n\nIf none of your dice rolled earn points, you get a Farkle. Three farkles in a row and you lose 1,000 points. \n\nYou continue rolling until you either bank your current turn or Farkle. Then the next player rolls the six dice. \n\nThe final round starts as soon as any player reaches 10,000 or more points. All other players besides the first one to reach 10,000 or greater get one more roll to try and surpass that player. \n'))),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                elevation: 5.0,
                child: Text('close'),
                color: Colors.teal[300],
                textColor: Colors.white,
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _backAPage(context),
        child: Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () => showRulesModal(
                      context,
                      MediaQuery.of(context).size.height * .8,
                      MediaQuery.of(context).size.width * .8),
                  child: Row(children: [Icon(Icons.rule), Text(' Rules')]))
            ],
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
                                child: Text('Go to scoring',
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
