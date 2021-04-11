import 'package:flutter/material.dart';

class ScoreboardScreen extends StatelessWidget {
  static const routeName = '/scoreboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Text('Scoreboard Screen', style: Theme.of(context).textTheme.bodyText1,),
          ),
        ],
      ),
    );
  }
}