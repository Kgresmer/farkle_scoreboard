import 'package:farkle_scoreboard/widgets/roster_player_list.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import './add_existing_player_screen.dart';
import '../providers/roster.dart';
import '../widgets/new_player.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './set_player_order_screen.dart';
import 'package:flutter/material.dart';

import 'landing_screen.dart';

class FillRosterScreen extends StatefulWidget {
  static const routeName = '/fill-roster';

  @override
  _FillRosterScreenState createState() => _FillRosterScreenState();
}

class _FillRosterScreenState extends State<FillRosterScreen> {
  final NavigationHistoryObserver historyObserver = NavigationHistoryObserver();

  void navToAddExistingPlayers(BuildContext ctx) {
    HapticFeedback.heavyImpact();
    Navigator.of(ctx).pushNamed(AddExistingPlayerScreen.routeName);
  }

  void navToSetPlayerOrder(BuildContext ctx, bool rosterIsEmpty) {
    HapticFeedback.heavyImpact();
    if (!rosterIsEmpty)
      Navigator.of(ctx).pushNamed(SetPlayerOrderScreen.routeName);
  }

  void addNewPlayer(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewPlayer(),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void backToLandingScreen(BuildContext ctx) {
    HapticFeedback.heavyImpact();
    Navigator.of(ctx).pushNamed(LandingScreen.routeName);
  }

  Future<bool> onWillPop(context) {
    String previousRoute = historyObserver.history[historyObserver.history.length - 2].settings.name;
    if (previousRoute == null || previousRoute == '/scoreboard') {
      Navigator.of(context).pushNamed(LandingScreen.routeName);
    } else {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rosterData = Provider.of<Roster>(context);
    final rosterPlayers = rosterData.players;

    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => backToLandingScreen(context),
          ),
          automaticallyImplyLeading: false,
          title: Text('Fill Your Roster',
              style: TextStyle(color: Theme.of(context).cardColor)),
        ),
        body: LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            children: <Widget>[
              Container(
                height: constraints.maxHeight * .78,
                child: rosterPlayers.length == 0
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(18, 35, 18, 0),
                        child: Text(
                            'Use existing and new players to build a roster for the game',
                            style: TextStyle(
                                color: Theme.of(context).disabledColor)),
                      )
                    : RosterPlayerList(rosterPlayers),
              ),
              Container(
                height: constraints.maxHeight * .22,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            height: constraints.maxHeight * .09,
                            width: constraints.maxWidth / 2 - 20,
                            padding: EdgeInsets.only(bottom: 5),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).secondaryHeaderColor,
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () => navToAddExistingPlayers(context),
                                child: Text('Add Existing Player'))),
                        Container(
                            height: constraints.maxHeight * .09,
                            width: constraints.maxWidth / 2 - 20,
                            padding: EdgeInsets.only(bottom: 5),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).secondaryHeaderColor,
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () => addNewPlayer(context),
                                child: Text('Add New Player')))
                      ],
                    ),
                    SizedBox(
                      height: constraints.maxHeight * .01,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              height: constraints.maxHeight * .09,
                              width: constraints.maxWidth - 25,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: rosterPlayers.length == 0
                                          ? Theme.of(context).disabledColor
                                          : Theme.of(context).shadowColor,
                                      textStyle: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () => navToSetPlayerOrder(
                                      context, rosterPlayers.length == 0),
                                  child: Text('Ready',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).canvasColor)))),
                        ]),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
