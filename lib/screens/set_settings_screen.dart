import '../models/Rules.dart';
import '../providers/roster.dart';
import './set_player_order_screen.dart';
import 'package:provider/provider.dart';
import './scoreboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../FileService.dart';

class SetSettingsScreen extends StatefulWidget {
  static const routeName = '/set-settings';

  @override
  _SetSettingsScreenState createState() => _SetSettingsScreenState();
}

class _SetSettingsScreenState extends State<SetSettingsScreen> {
  bool farkleRule = false;
  bool onesRule = false;
  bool entryPoint300 = false;
  bool entryPoint400 = false;
  bool entryPoint500 = false;

  @override
  void initState() {
    super.initState();
    () async {
      await FileService.readRulesContent().then((Rules rules) => {
            setState(() {
              farkleRule = rules.farkleRule;
              onesRule = rules.onesRule;
              entryPoint300 = rules.entryPoint300;
              entryPoint400 = rules.entryPoint400;
              entryPoint500 = rules.entryPoint500;
            })
          });
    }();
  }

  void navToScoreboard(BuildContext ctx) {
    HapticFeedback.heavyImpact();
    int entryScore = entryPoint300
        ? 300
        : entryPoint400
            ? 400
            : 500;
    Provider.of<Roster>(context, listen: false)
        .setRules(entryScore, farkleRule, onesRule);
    Rules newRuleChoices = new Rules(
        farkleRule, onesRule, entryPoint300, entryPoint400, entryPoint500);
    FileService.writeRulesContent(newRuleChoices);
    Navigator.of(ctx).pushNamed(ScoreboardScreen.routeName);
  }

  void backToSetOrder(BuildContext ctx) {
    HapticFeedback.heavyImpact();
    Rules newRuleChoices = new Rules(
        farkleRule, onesRule, entryPoint300, entryPoint400, entryPoint500);
    FileService.writeRulesContent(newRuleChoices);
    Navigator.of(ctx).pushNamed(SetPlayerOrderScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => backToSetOrder(context),
        ),
        title: Text('Set Game Settings',
            style: TextStyle(color: Theme.of(context).cardColor)),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
                color: Theme.of(context).secondaryHeaderColor,
                height: constraints.maxHeight * .06,
                child: Center(
                  child: Text('Choose scoring/gameplay options',
                      style: Theme.of(context).textTheme.displaySmall),
                )),
            Container(
                height: constraints.maxHeight * .82,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 10, 8, 0),
                      child: Text(
                        'Choose score value to enter the game',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 18),
                      child: Row(
                        children: <Widget>[
                          Transform.scale(
                            scale: 1.8,
                            child: Checkbox(
                              value: this.entryPoint300,
                              onChanged: (bool value) {
                                setState(() {
                                  this.entryPoint300 = value;
                                  this.entryPoint400 = false;
                                  this.entryPoint500 = false;
                                });
                              },
                            ),
                          ),
                          Text(
                            '300',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Transform.scale(
                            scale: 1.8,
                            child: Checkbox(
                              value: this.entryPoint400,
                              onChanged: (bool value) {
                                setState(() {
                                  this.entryPoint300 = false;
                                  this.entryPoint400 = value;
                                  this.entryPoint500 = false;
                                });
                              },
                            ),
                          ),
                          Text(
                            '400',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Transform.scale(
                            scale: 1.8,
                            child: Checkbox(
                              value: this.entryPoint500,
                              onChanged: (bool value) {
                                setState(() {
                                  this.entryPoint300 = false;
                                  this.entryPoint400 = false;
                                  this.entryPoint500 = value;
                                });
                              },
                            ),
                          ),
                          Text(
                            '500',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 18),
                      child: Row(
                        children: <Widget>[
                          Transform.scale(
                            scale: 1.8,
                            child: Checkbox(
                              value: this.farkleRule,
                              onChanged: (bool value) {
                                setState(() {
                                  this.farkleRule = value;
                                });
                              },
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Three farkles in a row results in minus 1000 points',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 18),
                      child: Row(
                        children: <Widget>[
                          Transform.scale(
                            scale: 1.8,
                            child: Checkbox(
                              value: this.onesRule,
                              onChanged: (bool value) {
                                setState(() {
                                  this.onesRule = value;
                                });
                              },
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Three ones is worth a 1000 rather than 300 and four ones is worth 1500 rather than 1000',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
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
                            onPressed: () => navToScoreboard(context),
                            child: Text('Ready to Start',
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
