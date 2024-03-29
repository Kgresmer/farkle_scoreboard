import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/RosterPlayer.dart';
import '../providers/roster.dart';
import '../providers/scoreboard.dart';

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
        description: '1 Five',
        imageUrl: 'assets/images/dice-five.png'),
    ScoreOption(
        value: 300,
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
        description: '3 Pairs',
        imageUrl: 'assets/images/dice-three-pairs.png'),
    ScoreOption(
        value: 1500,
        description: 'Full house',
        imageUrl: 'assets/images/dice-fullhouse.png'),
    ScoreOption(
        value: 2000,
        description: '5 of a kind',
        imageUrl: 'assets/images/dice-5-kind.png'),
    ScoreOption(
        value: 2500,
        description: '2 Triples',
        imageUrl: 'assets/images/dice-two-triples.png'),
    ScoreOption(
        value: 3000,
        description: '6 of a kind',
        imageUrl: 'assets/images/dice-6-kind.png'),
  ];
  bool animated = false;
  AudioCache _audioCache;
  bool warningSent = false;

  @override
  void initState() {
    super.initState();
    _audioCache = AudioCache(
      prefix: 'assets/audio/',
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );
    ScoreOption onesOption =
        scoreOptions.firstWhere((op) => op.description == '3 Ones');
    if (Provider.of<Roster>(context, listen: false).threeOnesIsAThousand) {
      onesOption.value = 1000;
      scoreOptions.insert(
          8,
          ScoreOption(
              value: 1500,
              description: '4 Ones',
              imageUrl: 'assets/images/dice-4-ones.png'));
    }
  }

  void closeScoreInput() {
    Navigator.of(context).pop();
  }

  void _bankIt() {
    int currentScore = Provider.of<Scoreboard>(context, listen: false).score;
    int startingScoreEntry =
        Provider.of<Roster>(context, listen: false).startingScoreEntry;
    RosterPlayer activePlayer = Provider.of<Roster>(context, listen: false)
        .players
        .firstWhere((p) => p.active);
    if (activePlayer.player.highestRoll < currentScore)
      activePlayer.player.highestRoll = currentScore;
    if (activePlayer.score == 0 && currentScore < startingScoreEntry) {
      final snackBar = SnackBar(
        content: Text(
            "You have to score above the minimum entry score of $startingScoreEntry",
            style: TextStyle(fontSize: 20, color: Colors.black)),
        backgroundColor: Theme.of(context).shadowColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(8),
        elevation: 3,
        duration: const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      RosterPlayer playerWhoWasJustUpdated =
          Provider.of<Roster>(context, listen: false).updateScore(currentScore);
      if (playerWhoWasJustUpdated.isComplete) {
        closeScoreInput();
      }
      Provider.of<Scoreboard>(context, listen: false).clearScore();
      RosterPlayer newActivePlayer = Provider.of<Roster>(context, listen: false)
          .players
          .firstWhere((p) => p.active);
      final snackBar = SnackBar(
        content: Text("${newActivePlayer.player.name} is now scoring",
            style: TextStyle(fontSize: 24, color: Colors.black)),
        backgroundColor: Theme.of(context).shadowColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(8),
        elevation: 3,
        duration: const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void updateCurrentScore(int value) {
    Provider.of<Scoreboard>(context, listen: false).updateScore(value);
    Vibration.vibrate(duration: 130, amplitude: 65);
    _audioCache.play('add_score.mp3');
    setState(() {
      animated = true;
    });
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        animated = false;
      });
    });
  }

  void addFarkle(int score) {
    Provider.of<Scoreboard>(context, listen: false).clearScore();
    if (score != 0) {
      Provider.of<Roster>(context, listen: false).addFarkle();
    } else {
      Provider.of<Roster>(context, listen: false).updateScore(0);
    }
    Navigator.of(context).pop();
  }

  void undoLastScoreUpdate() {
    Vibration.vibrate(duration: 130, amplitude: 65);
    if (Provider.of<Scoreboard>(context, listen: false).scoreUpdates.length >
        0) {
      Provider.of<Scoreboard>(context, listen: false).undoScore();
      setState(() {
        animated = !animated;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          animated = !animated;
        });
      });
    }
  }

  void displayWarningMessage() {
    if (!warningSent) {
      final snackBar = SnackBar(
        content: Text(
            "You have two farkles! Three in a row results in -1000 points!",
            style: TextStyle(fontSize: 24, color: Colors.black)),
        backgroundColor: Theme.of(context).shadowColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(8),
        elevation: 3,
        duration: const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        warningSent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentScore = Provider.of<Scoreboard>(context).score;
    RosterPlayer activePlayer = Provider.of<Roster>(context)
        .players
        .firstWhere((p) => p.active == true);

    if (activePlayer.farkles == 2 &&
        Provider.of<Roster>(context).threeFarklesIsMinusAThousand)
      displayWarningMessage();

    return Container(
      height: MediaQuery.of(context).size.height,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
            color: Theme.of(context).shadowColor,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 7,
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: <Widget>[
                                DefaultTextStyle(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  child: Text(
                                      '${activePlayer.player.name}\'s current score: '),
                                ),
                                DefaultTextStyle(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  child: Text('${activePlayer.score}'),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              DefaultTextStyle(
                                style: Theme.of(context).textTheme.bodyMedium,
                                child: Text('Current turn total: '),
                              ),
                              DefaultTextStyle(
                                style: Theme.of(context).textTheme.bodyMedium,
                                child: AnimatedDefaultTextStyle(
                                  child: Text('$currentScore'),
                                  style: animated
                                      ? TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 26,
                                        )
                                      : TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                  duration: Duration(milliseconds: 200),
                                ),
                              )
                            ],
                          ),
                        ])),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: TextButton(
                            child: Text('View Scores'),
                            onPressed: closeScoreInput,
                          ),
                        ))
                  ],
                ))),
        Flexible(
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: scoreOptions.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => updateCurrentScore(scoreOptions[index].value),
                child: Card(
                    color: Theme.of(context).dividerColor,
                    elevation: 5,
                    shadowColor: Colors.black,
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
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          '+ ' + scoreOptions[index].value.toString(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Image.asset(scoreOptions[index].imageUrl,
                            width: 180, height: 62, fit: BoxFit.contain)
                      ],
                    )),
              );
            },
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Container(
                    height: 65,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).secondaryHeaderColor,
                              textStyle: TextStyle(fontSize: 24)),
                          onPressed: undoLastScoreUpdate,
                          child: Text('Undo')),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    height: 65,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF6F061E),
                              textStyle: TextStyle(fontSize: 24)),
                          onPressed: () => addFarkle(activePlayer.score),
                          child: Text('Farkle')),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    height: 65,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).shadowColor,
                              textStyle: TextStyle(fontSize: 24)),
                          onPressed: _bankIt,
                          child: Text('Bank It',
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor))),
                    ),
                  )),
            ])
      ]),
    );
  }
}

class ScoreOption {
  int value;
  final String description;
  final String imageUrl;

  ScoreOption(
      {@required this.value,
      @required this.description,
      @required this.imageUrl});
}
