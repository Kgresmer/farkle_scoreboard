import 'package:farkle_scoreboard/widgets/existing_player_list.dart';
import './fill_roster_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExistingPlayerScreen extends StatelessWidget {
  static const routeName = '/add-existing-player';

  void backToFillYourRoster(BuildContext ctx) {
    HapticFeedback.heavyImpact();
    Navigator.of(ctx).pushNamed(FillRosterScreen.routeName);
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
        title: Text('Add Existing Players'),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
                height: constraints.maxHeight * .04,
                child: Center(
                  child: Text('click player card(s) to add to roster',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2),)
            ),
            Container(
              height: constraints.maxHeight * .84,
              child: ExistingPlayerList(),
            ),
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
                            onPressed: () => backToFillYourRoster(context),
                            child: Text('Done'))),
                  ]),
            ),
          ],
        );
      }),
    );
  }
}
