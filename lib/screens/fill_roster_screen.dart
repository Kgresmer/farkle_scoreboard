import 'package:farkle_scoreboard/widgets/roster_player_list.dart';

import '../FileService.dart';
import '../models/Player.dart';
import '../providers/existing_players.dart';
import './add_existing_player_screen.dart';
import '../providers/roster.dart';
import '../widgets/new_player.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './set_player_order_screen.dart';
import 'package:flutter/material.dart';

class FillRosterScreen extends StatefulWidget {
  static const routeName = '/fill-roster';

  @override
  _FillRosterScreenState createState() => _FillRosterScreenState();
}

class _FillRosterScreenState extends State<FillRosterScreen> {

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

  void backAPage(BuildContext ctx) {
    HapticFeedback.heavyImpact();
    Navigator.of(ctx).pop();
  }

  Future<bool> _backAPage(BuildContext context) async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final rosterData = Provider.of<Roster>(context);
    final rosterPlayers = rosterData.players;
    FileService.readContent().then((List<Player> players) => {
      Provider.of<ExistingPlayers>(context, listen: false).loadPlayers(players)
    });

    return WillPopScope(
      onWillPop: () => _backAPage(context),
      child: Scaffold(
        appBar: AppBar(
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
