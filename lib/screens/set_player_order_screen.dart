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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => backToFillRoster(context),
        ),
        title: Text('Set Player Order', style: TextStyle(color: Theme.of(context).cardColor)),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
                color: Theme.of(context).secondaryHeaderColor,
                height: constraints.maxHeight * .06,
                child: Center(
                  child: Text('click, hold and drag to change the order',
                      style: Theme.of(context).textTheme.displaySmall),
                )),
            Container(
                height: constraints.maxHeight * .82,
                child: ReorderableListView(
                  padding: const EdgeInsets.symmetric(vertical: 8,
                    horizontal: 6),
                  children: List.generate(_roster.length, (index) {
                    return Card(
                        key: UniqueKey(),
                        elevation: 5,
                        shadowColor: Colors.black,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 4,
                        ),
                        child: ListTile(
                            onTap: () {
                              Feedback.forTap(context);
                              HapticFeedback.heavyImpact();
                            },
                            tileColor: Theme.of(context).dividerColor,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 50),
                            title: Text(_roster[index].player.name,
                                style: Theme.of(context).textTheme.headlineLarge),
                            trailing: Icon(Icons.zoom_out_map, color: Theme.of(context).cardColor, size: 37,)));
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
                  proxyDecorator: (Widget child, int index, Animation<double> animation) {
                    return Material(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 4,
                              blurRadius: 4,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: child,
                      ),
                    );
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
                                backgroundColor: Theme.of(context).shadowColor,
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            onPressed: () => navToScoreboard(context),
                            child: Text('Ready to Start', style: TextStyle(color: Theme.of(context).canvasColor) ))),
                  ]),
            ),
          ],
        );
      }),
    );
  }
}
