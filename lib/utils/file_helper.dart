import 'dart:io';

import 'logger.dart';

/// Creates a directory at [path] (including any missing parents).
///
/// Returns `true` if it was created, or `false` if it already existed.
bool createDirectory(String path) {
  final dir = Directory(path);

  if (dir.existsSync()) {
    return false;
  }

  dir.createSync(recursive: true);
  logCreate(path);
  return true;
}

/// Creates a file at [path] and writes [content] to it.
///
/// Existing files are never overwritten. Returns `true` if the file was
/// created, or `false` if it already existed (a skip is logged in that case).
bool createFile(String path, String content) {
  final file = File(path);

  if (file.existsSync()) {
    logSkip(path);
    return false;
  }

  file.createSync(recursive: true);
  file.writeAsStringSync(content);
  logCreate(path);
  return true;
}

/// Creates [dirPath] then writes a file named [fileName] inside it with the
/// given [content].
///
/// Returns `true` if the file was created, or `false` if it already existed.
bool createDirectoryWithFile(String dirPath, String fileName, String content) {
  createDirectory(dirPath);
  return createFile('$dirPath/$fileName', content);
}
