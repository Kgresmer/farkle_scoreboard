import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';

class ScoreInput extends StatefulWidget {
  @override
  _ScoreInputState createState() => _ScoreInputState();
}

class _ScoreInputState extends State<ScoreInput> {
  List<ScoreOption> scoreOptions = [
    ScoreOption(
        value: 100,
        description: '1 One',
        imageUrl: 'assets/images/dice-one.png'),
    ScoreOption(
        value: 50,
        description: '1 five',
        imageUrl: 'assets/images/dice-five.png'),
    ScoreOption(
        value: 1000,
        description: '3 Ones',
        imageUrl: 'assets/images/dice-3-ones.png'),
    ScoreOption(
        value: 200,
        description: '3 Twos',
        imageUrl: 'assets/images/dice-3-twos.png'),
    ScoreOption(
        value: 300,
        description: '3 Threes',
        imageUrl: 'assets/images/dice-3-threes.png'),
    ScoreOption(
        value: 400,
        description: '3 Fours',
        imageUrl: 'assets/images/dice-3-fours.png'),
    ScoreOption(
        value: 500,
        description: '3 Fives',
        imageUrl: 'assets/images/dice-3-fives.png'),
    ScoreOption(
        value: 600,
        description: '3 Sixes',
        imageUrl: 'assets/images/dice-3-sixes.png'),
    ScoreOption(
        value: 1000,
        description: '4 of a kind',
        imageUrl: 'assets/images/dice-4-kind.png'),
    ScoreOption(
        value: 1500,
        description: 'Straight',
        imageUrl: 'assets/images/dice-straight.png'),
    ScoreOption(
        value: 1500,
        description: '3 pairs',
        imageUrl: 'assets/images/dice-three-pairs.png'),
    ScoreOption(
        value: 2500,
        description: '2 triples',
        imageUrl: 'assets/images/dice-two-triples.png'),
    ScoreOption(
        value: 2000,
        description: '5 of a kind',
        imageUrl: 'assets/images/dice-5-kind.png'),
    ScoreOption(
        value: 3000,
        description: '6 of a kind',
        imageUrl: 'assets/images/dice-6-kind.png'),
  ];
  int currentScore = 0;
  List<int> scoreUpdates = [];
  bool animated = false;
  AudioCache _audioCache;

  @override
  void initState() {
    super.initState();
    _audioCache = AudioCache(
      prefix: 'assets/audio/',
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );
  }

  void _bankIt() {
    Navigator.of(context).pop();
  }

  void updateCurrentScore(int value) {
    Vibration.vibrate(duration: 130, amplitude: 65);
    _audioCache.play('add_score.mp3');
    setState(() {
      currentScore += value;
      scoreUpdates.add(value);
      animated = !animated;
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        animated = !animated;
      });
    });
  }

  void undoLastScoreUpdate() {
    Vibration.vibrate(duration: 130, amplitude: 65);
    if (scoreUpdates.length > 0) {
      setState(() {
        int lastUpdate = scoreUpdates.removeAt(scoreUpdates.length - 1);
        currentScore -= lastUpdate;
        animated = !animated;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          animated = !animated;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.90,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Flexible(
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: scoreOptions.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => updateCurrentScore(scoreOptions[index].value),
                child: Card(
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
                            width: 180, height: 70, fit: BoxFit.contain)
                      ],
                    )),
              );
            },
          ),
        ),
        Container(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
                child: Row(children: <Widget>[
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyText1,
                    child: Text('Current Turn Total: '),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyText1,
                    child: AnimatedDefaultTextStyle(
                      child: Text('$currentScore'),
                      style: animated
                          ? TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                            )
                          : TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                      duration: Duration(milliseconds: 200),
                    ),
                  ),
                ]))),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 160,
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          textStyle: TextStyle(fontSize: 24)),
                      onPressed: undoLastScoreUpdate,
                      child: Text('Undo')),
                ),
              ),
              Container(
                width: 160,
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          textStyle: TextStyle(fontSize: 24)),
                      onPressed: _bankIt,
                      child: Text('Bank It')),
                ),
              ),
            ])
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
