import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'models/Player.dart';
import 'models/Rules.dart';

class FileService {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localPlayersFile async {
    final path = await _localPath;
    try {
      return File('$path/players.txt');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<File> get _localRulesFile async {
    final path = await _localPath;
    try {
      return File('$path/rules.txt');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<Player>> readPlayersContent() async {
    try {
      final file = await _localPlayersFile;
      String jsonString = await file.readAsString();
      List<Object> objects = jsonDecode(jsonString);
      List<Player> players = [];
      objects.forEach((p) => {players.add(Player.fromJsonMap(p))});

      return players;
    } catch (e) {
      return [];
    }
  }

  static Future<Rules> readRulesContent() async {
    try {
      final file = await _localRulesFile;
      String jsonString = await file.readAsString();

      var json = jsonDecode(jsonString);
      return Rules.fromJsonMap(json);
    } catch (e) {
      return new Rules(false, false, false, true, false);
    }
  }

  static Future<File> writePlayerContent(List<Player> players) async {
    final file = await _localPlayersFile;
    String jsonPlayers = jsonEncode(players);
    return file.writeAsString(jsonPlayers);
  }

  static Future<File> writeRulesContent(Rules rules) async {
    final file = await _localRulesFile;
    String jsonPlayers = jsonEncode(rules);
    return file.writeAsString(jsonPlayers);
  }
}
