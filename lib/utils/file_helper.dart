import 'dart:io';

import 'logger.dart';

/// Creates a directory at [path] (including any missing parents).
/// Does nothing if it already exists.
void createDirectory(String path) {
  final dir = Directory(path);

  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
    logCreate(path);
  }
}

/// Creates a file at [path] and writes [content] to it.
/// Does nothing if the file already exists.
void createFile(String path, String content) {
  final file = File(path);

  if (!file.existsSync()) {
    file.createSync(recursive: true);
    file.writeAsStringSync(content);
    logCreate(path);
  }
}

/// Creates [dirPath] then writes a file named [fileName] inside it
/// with the given [content].
void createDirectoryWithFile(String dirPath, String fileName, String content) {
  createDirectory(dirPath);
  createFile('$dirPath/$fileName', content);
}
