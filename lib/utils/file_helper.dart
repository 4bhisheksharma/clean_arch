import 'dart:io';
import 'logger.dart';

void createDirectory(String path) {
  final dir = Directory(path);

  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
    logCreate(path);
  }
}

void createFile(String path, String content) {
  final file = File(path);

  if (!file.existsSync()) {
    file.createSync(recursive: true);
    file.writeAsStringSync(content);
    logCreate(path);
  }
}