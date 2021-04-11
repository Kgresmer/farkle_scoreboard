import 'package:flutter/material.dart';

class FillRosterScreen extends StatelessWidget {
  static const routeName = '/fill-roster';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.arrow_back), title: Text('Fill Your Roster'),),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: constraints.maxHeight * .78,
              width: double.infinity,
              child: Center(
                child: Text(
                  'people',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
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
                                  textStyle: TextStyle(fontSize: 18)),
                              onPressed: () {}, child: Text('Add Existing Player'))),
                      Container(
                          height: constraints.maxHeight * .09,
                          width: constraints.maxWidth / 2 - 20,
                          padding: EdgeInsets.only(bottom: 5),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                 textStyle: TextStyle(fontSize: 18)),
                              onPressed: () {}, child: Text('Add New Player')))
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
                                    backgroundColor: Colors.deepOrange, textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                                onPressed: () => {},
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