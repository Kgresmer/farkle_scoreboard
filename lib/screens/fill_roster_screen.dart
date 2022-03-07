import './add_existing_player_screen.dart';
import '../providers/roster.dart';
import '../widgets/new_player.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './set_player_order_screen.dart';
import 'package:flutter/material.dart';

class FillRosterScreen extends StatelessWidget {
  static const routeName = '/fill-roster';

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

  @override
  Widget build(BuildContext context) {
    final rosterData = Provider.of<Roster>(context);
    final rosterPlayers = rosterData.players;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => backAPage(context),
        ),
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
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          child: ListTile(
                            tileColor: Theme.of(context).dividerColor,
                            isThreeLine: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            leading: Container(
                              height: double.infinity,
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor:
                                      Theme.of(context).shadowColor,
                                  child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: FittedBox(
                                        child: Text(
                                            rosterPlayers[index]
                                                .player
                                                .name
                                                .substring(0, 1),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge),
                                      ))),
                            ),
                            title: Text(
                              rosterPlayers[index].player.name,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      'Wins: ${rosterPlayers[index].player.wins} | Losses: ${rosterPlayers[index].player.losses}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                  Text(
                                      'Best Score: ${rosterPlayers[index].player.bestScore}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                ]),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.remove_circle_outline,
                              ),
                              iconSize: 45,
                              color: Theme.of(context).canvasColor,
                              onPressed: () => {
                                Provider.of<Roster>(context, listen: false)
                                    .removePlayer(rosterPlayers[index].player)
                              },
                            ),
                          ),
                        );
                      },
                      itemCount: rosterPlayers.length,
                    ),
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
    );
  }
}
