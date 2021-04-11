import 'package:flutter/material.dart';

class SetPlayerOrderScreen extends StatelessWidget {
  static const routeName = '/set-player-order';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Text('Set Player Order Screen', style: Theme.of(context).textTheme.bodyText1,),
          ),
        ],
      ),
    );
  }
}