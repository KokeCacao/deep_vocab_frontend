import 'dart:async';
import 'dart:convert';
import 'dart:io';

class FileManager {
  // see: https://stackoverflow.com/questions/14268967/how-do-i-list-the-contents-of-a-directory-with-dart
  static Future<List<FileSystemEntity>> dirContents(Directory dir) {
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: false);
    lister.listen((file) => files.add(file),
        // TODO: should also register onError
        onDone: () => completer.complete(files));
    return completer.future;
  }

  static void printDir(Directory dir) async {
    List<FileSystemEntity> entityList = await dirContents(dir);
    for (FileSystemEntity entity in entityList) print(entity.path);
  }

  static Future<Map<String, dynamic>> filePathToJson(String path) async {
    String s = await new File(path).readAsString();
    print("[FileManager] read:\n${s}");
    return Future.value(json.decode(s) as Map<String, dynamic>);
  }

  static Future<void> deteleFile(String path) async {
    await File(path).delete();
    print("[FileManager] deleted: ${path}");
  }
}
