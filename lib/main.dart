import 'package:farkle_scoreboard/screens/game_over_screen.dart';

import './providers/scoreboard.dart';
import './providers/roster.dart';
import './screens/add_existing_player_screen.dart';
import './screens/fill_roster_screen.dart';
import './screens/results_screen.dart';
import './screens/scoreboard_screen.dart';
import './screens/set_player_order_screen.dart';
import './screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/existing_players.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var yellow = const Color(0xD9fccd00);
  var blackish = const Color(0xFF3b3530);
  var teal = const Color(0xD94990a3);
  var white = const Color(0xF2f3f9f9);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ExistingPlayers(),
        ),
        ChangeNotifierProvider.value(
          value: Roster(),
        ),
        ChangeNotifierProvider.value(
          value: Scoreboard(),
        )
      ],
      child: MaterialApp(
        title: 'Farkle_Scoreboard',
        theme: ThemeData(
            backgroundColor: blackish,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  backgroundColor: teal,
                  primary: white,
                  elevation: 0,
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  padding: EdgeInsets.all(10)),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                primary: yellow,
                onPrimary: blackish,
                textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: blackish),
              ),
            ),
            secondaryHeaderColor: teal,
            shadowColor: yellow,
            canvasColor: blackish,
            cardColor: white,
            dividerColor: teal,
            disabledColor: Colors.white54,
            textTheme: ThemeData.light().textTheme.copyWith(
                displayMedium: TextStyle(
                    fontSize: 20, color: white, fontWeight: FontWeight.w600),
                displaySmall: TextStyle(
                    fontSize: 18, color: white, fontWeight: FontWeight.w500),
                bodySmall: TextStyle(
                    color: blackish, fontSize: 18, fontWeight: FontWeight.w500),
                bodyMedium: TextStyle(
                    color: blackish, fontSize: 22, fontWeight: FontWeight.w500),
                headlineLarge: TextStyle(
                    color: white, fontSize: 23, fontWeight: FontWeight.w600),
                headlineMedium: TextStyle(
                    color: white, fontSize: 18, fontWeight: FontWeight.w500),
                titleLarge: TextStyle(
                    color: blackish, fontSize: 23, fontWeight: FontWeight.w600),
                titleMedium: TextStyle(
                    color: blackish, fontSize: 18, fontWeight: FontWeight.w500)),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: AppBarTheme(
                color: teal,
                toolbarTextStyle: TextStyle(color: white),
                iconTheme: IconThemeData(color: white))),
        initialRoute: '/',
        routes: {
          '/': (ctx) => LandingScreen(),
          AddExistingPlayerScreen.routeName: (ctx) => AddExistingPlayerScreen(),
          FillRosterScreen.routeName: (ctx) => FillRosterScreen(),
          ResultsScreen.routeName: (ctx) => ResultsScreen(),
          ScoreboardScreen.routeName: (ctx) => ScoreboardScreen(),
          SetPlayerOrderScreen.routeName: (ctx) => SetPlayerOrderScreen(),
          GameOverScreen.routeName: (ctx) => GameOverScreen(),
        },
        onUnknownRoute: (settings) {
          // could be 404 page - fallback page
          return MaterialPageRoute(builder: (ctx) => LandingScreen());
        },
      ),
    );
  }
}
