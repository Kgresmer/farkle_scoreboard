import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileService {

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  static Future<String> readcontent() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      // TODO turn into players
      return contents;
    } catch (e) {
      return 'Error';
    }
  }

  static Future<File> writeContent(String content) async {
    final file = await _localFile;
    print('writing $content');
    return file.writeAsString(content);
  }
}