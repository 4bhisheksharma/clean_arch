import 'dart:io';
import 'package:test/test.dart';

void main() {
  final testDir = '${Directory.systemTemp.path}/clean_arch_test';

  setUp(() {
    final dir = Directory(testDir);
    if (dir.existsSync()) dir.deleteSync(recursive: true);
    dir.createSync(recursive: true);
  });

  tearDown(() {
    final dir = Directory(testDir);
    if (dir.existsSync()) dir.deleteSync(recursive: true);
  });

  test('createDirectory creates nested directories', () {
    final path = '$testDir/a/b/c';
    Directory(path).createSync(recursive: true);
    expect(Directory(path).existsSync(), isTrue);
  });

  test('createFile creates a file with content', () {
    final path = '$testDir/sample.dart';
    final file = File(path);
    file.createSync(recursive: true);
    file.writeAsStringSync('hello');
    expect(file.existsSync(), isTrue);
    expect(file.readAsStringSync(), 'hello');
  });
}
