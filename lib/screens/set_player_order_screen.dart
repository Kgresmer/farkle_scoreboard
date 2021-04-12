import './scoreboard_screen.dart';
import '../models/Player.dart';
import 'package:flutter/material.dart';

class SetPlayerOrderScreen extends StatefulWidget {
  static const routeName = '/set-player-order';

  @override
  _SetPlayerOrderScreenState createState() => _SetPlayerOrderScreenState();
}

class _SetPlayerOrderScreenState extends State<SetPlayerOrderScreen> {
  final List<Player> _roster = [
    Player(name: 'Kevin', color: 1, wins: 5, losses: 1, bestScore: 10200),
    Player(name: 'Sigrid', color: 2, wins: 1, losses: 5, bestScore: 9900),
    Player(name: 'Sam', color: 2, wins: 1, losses: 5, bestScore: 9900),
    Player(name: 'Samantha', color: 2, wins: 1, losses: 5, bestScore: 9900),
    Player(name: 'Steve', color: 2, wins: 1, losses: 5, bestScore: 9900),
    Player(name: 'Wendy', color: 2, wins: 1, losses: 5, bestScore: 9900)
  ];

  void navToScoreboard(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(ScoreboardScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Set Player Order'),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
                height: constraints.maxHeight * .04,
                child: Center(
                  child: Text('click, hold and drag to change the order',
                      style: Theme.of(context).textTheme.bodyText2),
                )),
            Container(
                height: constraints.maxHeight * .84,
                child: ReorderableListView(
                  children: List.generate(_roster.length, (index) {
                    return Card(
                        key: UniqueKey(),
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 5,
                        ),
                        child: ListTile(contentPadding: EdgeInsets.symmetric(horizontal: 50),
                            title: Text(_roster[index].name,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline6),
                            trailing: Icon(Icons.zoom_out_map)));
                  }),
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final Player newPlayer = _roster.removeAt(oldIndex);
                      _roster.insert(newIndex, newPlayer);
                    });
                  },
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
                                backgroundColor: Colors.deepOrange,
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            onPressed: () => navToScoreboard(context),
                            child: Text('Ready to Start'))),
                  ]),
            ),
          ],
        );
      }),
    );
  }
}
