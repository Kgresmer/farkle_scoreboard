import './fill_roster_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  static const routeName = '/landing';

  void navToScoreAGame(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(FillRosterScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: null,
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * .8,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Welcome to \nFarkle Scoreboard',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
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
                                    backgroundColor: Colors.deepOrange, textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
                              onPressed: () {}, child: Text('Player Stats'))),
                      Container(
                          height: constraints.maxHeight * .09,
                          width: constraints.maxWidth / 2 - 20,
                          child: TextButton(
                              onPressed: () {}, child: Text('Rules')))
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
