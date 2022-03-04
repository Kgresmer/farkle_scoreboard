import 'package:provider/provider.dart';
import '../providers/roster.dart';
import './fill_roster_screen.dart';
import './scoreboard_screen.dart';
import '../models/RosterPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetPlayerOrderScreen extends StatefulWidget {
  static const routeName = '/set-player-order';

  @override
  _SetPlayerOrderScreenState createState() => _SetPlayerOrderScreenState();
}

class _SetPlayerOrderScreenState extends State<SetPlayerOrderScreen> {
  List<RosterPlayer> _roster = [];

  @override
  void initState() {
    super.initState();

    final rosterData = Provider.of<Roster>(context, listen: false);
    setState(() {
      _roster = [...rosterData.players];
    });
  }

  void navToScoreboard(BuildContext ctx) {
    HapticFeedback.heavyImpact();
    // set play order
    for(var i=0; i<_roster.length; i++){
      Provider.of<Roster>(context, listen: false).setPlayOrder(_roster[i], i, i == 0);
    }
    Navigator.of(ctx).pushNamed(ScoreboardScreen.routeName);
  }

  void backToFillRoster(BuildContext ctx) {
    HapticFeedback.heavyImpact();
    Navigator.of(ctx).pushNamed(FillRosterScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => backToFillRoster(context),
        ),
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
                        child: ListTile(
                            onTap: () {
                              Feedback.forTap(context);
                              HapticFeedback.heavyImpact();
                            },
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 50),
                            title: Text(_roster[index].player.name,
                                style: Theme.of(context).textTheme.headline6),
                            trailing: Icon(Icons.zoom_out_map)));
                  }),
                  onReorder: (int oldIndex, int newIndex) {
                    HapticFeedback.heavyImpact();
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final RosterPlayer newPlayer = _roster.removeAt(oldIndex);
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
