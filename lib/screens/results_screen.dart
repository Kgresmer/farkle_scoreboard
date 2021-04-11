import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  static const routeName = '/results';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Text('Results Screen', style: Theme.of(context).textTheme.bodyText1,),
          ),
        ],
      ),
    );
  }
}