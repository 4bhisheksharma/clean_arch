import 'package:clean_arch/commands/feature_command.dart';
import 'package:clean_arch/commands/init_command.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    _printUsage();
    return;
  }

  final command = args[0];

  switch (command) {
    case 'init':
      runInit();

    case 'feature':
      if (args.length < 2) {
        print('Usage: clean_arch feature <name>');
        return;
      }
      runFeature(args[1]);

    default:
      print("Unknown command: '$command'");
      _printUsage();
  }
}

void _printUsage() {
  print('Usage:');
  print('  clean_arch init');
  print('  clean_arch feature <name>');
}
