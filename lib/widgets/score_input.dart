import 'package:flutter/material.dart';

class ScoreInput extends StatefulWidget {
  @override
  _ScoreInputState createState() => _ScoreInputState();
}

class _ScoreInputState extends State<ScoreInput> {
  final _nameController = TextEditingController();
  List<ScoreOption> scoreOptions = [
    ScoreOption(value: 100, description: '1 One', imageUrl: 'assets/images/dice-one.png'),
    ScoreOption(value: 50, description: '1 five', imageUrl: 'assets/images/dice-five.png'),
    ScoreOption(value: 1000, description: '3 Ones', imageUrl: 'assets/images/dice-one.png'),
    ScoreOption(value: 1000, description: '4 of a kind', imageUrl: 'assets/images/dice-one.png'),
    ScoreOption(value: 1500, description: 'Straight', imageUrl: 'assets/images/dice-one.png'),
    ScoreOption(value: 1500, description: '3 pairs', imageUrl: 'assets/images/dice-one.png'),
    ScoreOption(value: 2500, description: '2 triples', imageUrl: 'assets/images/dice-one.png'),
    ScoreOption(value: 2000, description: '5 of a kind', imageUrl: 'assets/images/dice-one.png'),
    ScoreOption(value: 3000, description: '6 of a kind', imageUrl: 'assets/images/dice-one.png'),
  ];

  void _submitData() {
    final nameInput = _nameController.text;
    if (nameInput.isEmpty) return;

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Flexible(
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: scoreOptions.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        scoreOptions[index].description,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        '+ ' + scoreOptions[index].value.toString(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Image.asset(scoreOptions[index].imageUrl,
                          width: 60, height: 60, fit: BoxFit.contain)
                    ],
                  ));
            },
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                textStyle: TextStyle(fontSize: 18)),
            onPressed: () => {},
            child: Text('Undo'))
      ]),
    );
  }
}

class ScoreOption {
  final int value;
  final String description;
  final String imageUrl;

  ScoreOption(
      {@required this.value,
      @required this.description,
      @required this.imageUrl});
}
