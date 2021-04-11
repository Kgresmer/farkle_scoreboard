import './screens/add_existing_player_screen.dart';
import './screens/fill_roster_screen.dart';
import './screens/results_screen.dart';
import './screens/scoreboard_screen.dart';
import './screens/set_player_order_screen.dart';
import './screens/landing_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        backgroundColor: Colors.teal,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: Colors.teal[300],
              primary: Colors.white,
              elevation: 0,
              textStyle: TextStyle(
                fontSize: 20,
              ),
              padding: EdgeInsets.all(10)),
        ),
        accentColor: Colors.deepOrange,
        canvasColor: Colors.teal,
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(fontSize: 20, color: Colors.white, ),
            bodyText2: TextStyle(color: Colors.white),
            headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(color: Colors.teal)
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => LandingScreen(),
        AddExistingPlayerScreen.routeName: (ctx) => AddExistingPlayerScreen(),
        FillRosterScreen.routeName: (ctx) => FillRosterScreen(),
        ResultsScreen.routeName: (ctx) => ResultsScreen(),
        ScoreboardScreen.routeName: (ctx) => ScoreboardScreen(),
        SetPlayerOrderScreen.routeName: (ctx) => SetPlayerOrderScreen(),
      },
      onUnknownRoute: (settings) {
        // could be 404 page - fallback page
        return MaterialPageRoute(builder: (ctx) => LandingScreen());
      },
    );
  }
}
