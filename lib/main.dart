import 'package:navigation_history_observer/navigation_history_observer.dart';

import './screens/game_over_screen.dart';
import './providers/scoreboard.dart';
import './providers/roster.dart';
import './screens/add_existing_player_screen.dart';
import './screens/fill_roster_screen.dart';
import './screens/results_screen.dart';
import './screens/scoreboard_screen.dart';
import './screens/set_player_order_screen.dart';
import './screens/set_settings_screen.dart';
import './screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/existing_players.dart';
import 'package:flutter/services.dart';

void main() async => {
      WidgetsFlutterBinding.ensureInitialized(),
      await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp],
      ),
      runApp(MyApp())
    };

class MyApp extends StatelessWidget {
  static const yellow = const Color(0xFFfccd00);
  static const blackish = const Color(0xFF3b3530);
  static const teal = const Color(0xD93D798A);
  static const white = const Color(0xF2f3f9f9);

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
        debugShowCheckedModeBanner: false,
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
                textStyle: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: blackish),
              ),
            ),
            checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateProperty.all(teal),
              checkColor: MaterialStateProperty.all(yellow),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              ),
            ),
            secondaryHeaderColor: teal,
            shadowColor: yellow,
            canvasColor: blackish,
            cardColor: white,
            dividerColor: teal,
            disabledColor: Colors.white54,
            textTheme: ThemeData.light().textTheme.copyWith(
                displayLarge: TextStyle(shadows: <Shadow>[
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0,
                    color: teal,
                  ),
                ], fontSize: 26, color: yellow, fontWeight: FontWeight.bold),
                displayMedium: TextStyle(
                    fontSize: 20, color: white, fontWeight: FontWeight.w600),
                displaySmall: TextStyle(
                    fontSize: 18, color: white, fontWeight: FontWeight.w500),
                bodySmall: TextStyle(
                    color: blackish, fontSize: 18, fontWeight: FontWeight.w500),
                bodyMedium: TextStyle(
                    color: blackish, fontSize: 23, fontWeight: FontWeight.w500),
                headlineLarge: TextStyle(
                    color: white, fontSize: 23, fontWeight: FontWeight.w600),
                headlineMedium: TextStyle(
                    color: white, fontSize: 18, fontWeight: FontWeight.w500),
                titleLarge: TextStyle(
                    color: blackish, fontSize: 23, fontWeight: FontWeight.bold),
                titleMedium: TextStyle(
                    color: blackish,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: AppBarTheme(
                color: teal,
                toolbarTextStyle: TextStyle(color: white, fontSize: 26),
                iconTheme: IconThemeData(color: white))),
        initialRoute: '/',
        routes: {
          '/': (ctx) => LandingScreen(),
          AddExistingPlayerScreen.routeName: (ctx) => AddExistingPlayerScreen(),
          FillRosterScreen.routeName: (ctx) => FillRosterScreen(),
          ResultsScreen.routeName: (ctx) => ResultsScreen(),
          ScoreboardScreen.routeName: (ctx) => ScoreboardScreen(),
          SetSettingsScreen.routeName: (ctx) => SetSettingsScreen(),
          SetPlayerOrderScreen.routeName: (ctx) => SetPlayerOrderScreen(),
          GameOverScreen.routeName: (ctx) => GameOverScreen(),
        },
        onUnknownRoute: (settings) {
          // could be 404 page - fallback page
          return MaterialPageRoute(builder: (ctx) => LandingScreen());
        },
        navigatorObservers: [NavigationHistoryObserver()],
      ),
    );
  }
}
