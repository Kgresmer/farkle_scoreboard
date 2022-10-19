import '../FileService.dart';
import './add_existing_player_screen.dart';
import './fill_roster_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LandingScreen extends StatelessWidget {
  static const routeName = '/landing';

  void navToScoreAGame(BuildContext ctx) {
    HapticFeedback.heavyImpact();
    Navigator.of(ctx).pushNamed(FillRosterScreen.routeName);
  }

  void navToExistingPlayers(BuildContext ctx) {
    HapticFeedback.heavyImpact();
    Navigator.of(ctx).pushNamed(AddExistingPlayerScreen.routeName);
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
    return Scaffold(
      appBar: null,
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              color: const Color(0xFFfccd00),
              margin: EdgeInsets.only(bottom: 10),
              height: constraints.maxHeight * .8 - 10,
              width: double.infinity,
              child: Center(
                child: Image.asset('assets/images/home_screen_logo.png',
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * .8,
                    fit: BoxFit.contain),
              ),
            ),
            Container(
              height: constraints.maxHeight * .2,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            height: constraints.maxHeight * .09,
                            width: constraints.maxWidth - 25,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    primary: Theme.of(context).canvasColor,
                                    backgroundColor:
                                        Theme.of(context).shadowColor,
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () => navToScoreAGame(context),
                                child: Text('Score A Game'))),
                      ]),
                  SizedBox(
                    height: constraints.maxHeight * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          height: constraints.maxHeight * .09,
                          width: constraints.maxWidth / 2 - 20,
                          child: TextButton(
                              onPressed: () => navToExistingPlayers(context),
                              child: Text('Player Stats'))),
                      Container(
                          height: constraints.maxHeight * .09,
                          width: constraints.maxWidth / 2 - 20,
                          child: TextButton(
                              onPressed: () => showRulesModal(
                                  context,
                                  constraints.maxHeight * .8,
                                  constraints.maxWidth * .8),
                              child: Text('Rules')))
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
