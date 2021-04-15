import 'package:farkle_scoreboard/widgets/new_player.dart';
import 'package:flutter/services.dart';
import './set_player_order_screen.dart';
import './add_existing_player_screen.dart';
import '../models/Player.dart';
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

  void navToSetPlayerOrder(BuildContext ctx) {
    HapticFeedback.heavyImpact();
    Navigator.of(ctx).pushNamed(SetPlayerOrderScreen.routeName);
  }

  final List<Player> _roster = [
    Player(name: 'Kevin', color: 1, wins: 5, losses: 1, bestScore: 10200),
    Player(name: 'Sigrid', color: 2, wins: 1, losses: 5, bestScore: 9900),
    Player(name: 'Sigrid1', color: 2, wins: 2, losses: 5, bestScore: 9900),
    Player(name: 'Sigrid2', color: 2, wins: 3, losses: 5, bestScore: 9900),
    Player(name: 'Sigrid3', color: 2, wins: 4, losses: 5, bestScore: 9900),
    Player(name: 'Sigrid4', color: 2, wins: 5, losses: 5, bestScore: 9900),
    Player(name: 'Sigrid5', color: 2, wins: 6, losses: 5, bestScore: 9900),
  ];

  void removeFromRoster(int index) {
    setState(() {
      _roster.removeAt(index);
    });
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => backAPage(context),),
        title: Text('Fill Your Roster'),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * .78,
              child: ListView.builder(
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
                      isThreeLine: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      leading: Container(
                        height: double.infinity,
                        child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.teal,
                            child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: FittedBox(
                                  child: Text(
                                      _roster[index].name.substring(0, 1),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ))),
                      ),
                      title: Text(
                        _roster[index].name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                'Wins: ${_roster[index].wins} | Losses: ${_roster[index].losses}',
                                style: Theme.of(context).textTheme.headline5),
                            Text('Best Score: ${_roster[index].bestScore}',
                                style: Theme.of(context).textTheme.headline5),
                          ]),
                      trailing: IconButton(
                        icon: const Icon(Icons.clear),
                        iconSize: 35,
                        color: Theme.of(context).errorColor,
                        onPressed: () => removeFromRoster(index),
                      ),
                    ),
                  );
                },
                itemCount: _roster.length,
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
                                  backgroundColor: Colors.teal,
                                  textStyle: TextStyle(fontSize: 18)),
                              onPressed: () => navToAddExistingPlayers(context),
                              child: Text('Add Existing Player'))),
                      Container(
                          height: constraints.maxHeight * .09,
                          width: constraints.maxWidth / 2 - 20,
                          padding: EdgeInsets.only(bottom: 5),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  textStyle: TextStyle(fontSize: 18)),
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
                                    backgroundColor: Colors.deepOrange,
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () => navToSetPlayerOrder(context),
                                child: Text('Ready'))),
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
