import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'models/Player.dart';

class FileService {

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    try {
      return File('$path/data.txt');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<Player>> readContent() async {
    try {
      final file = await _localFile;
      String jsonString = await file.readAsString();
      List<Object> objects = jsonDecode(jsonString);
      List<Player> players = [];
      objects.forEach((p) =>
      {
        players.add(Player.fromJsonMap(p))
      });

      return players;
    } catch (e) {
      return [];
    }
  }

  static Future<File> writeContent(List<Player> players) async {
    final file = await _localFile;
    String jsonPlayers = jsonEncode(players);
    return file.writeAsString(jsonPlayers);
  }
}