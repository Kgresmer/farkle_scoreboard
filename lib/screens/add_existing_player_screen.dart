import 'package:flutter/material.dart';

class AddExistingPlayerScreen extends StatelessWidget {
  static const routeName = '/add-existing-player';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Text('AddExistingPlayerScreen', style: Theme.of(context).textTheme.bodyText1,),
          ),
        ],
      ),
    );
  }
}