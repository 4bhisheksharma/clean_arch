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
      _handleInit(args);
      break;

    case 'normal':
      _handleNormal(args);
      break;

    case 'feature':
      _handleFeature(args);
      break;

    default:
      print("Unknown command: '$command'");
      _printUsage();
      break;
  }
}

void _handleInit(List<String> args) {
  final architectureType = args.length >= 2 ? args[1] : null;
  runInit(architectureType: architectureType);
}

void _handleFeature(List<String> args) {
  if (args.length < 2) {
    print('Usage: clean_arch feature <name>');
    return;
  }

  runFeature(args[1]);
}

void _handleNormal(List<String> args) {
  if (args.length < 2) {
    print('Usage: clean_arch normal <init|feature> [name]');
    return;
  }

  final subCommand = args[1];

  switch (subCommand) {
    case 'init':
      runNormalInit();
      break;
    case 'feature':
      if (args.length < 3) {
        print('Usage: clean_arch normal feature <name>');
        return;
      }
      runFeature(args[2], architectureType: 'normal');
      break;
    default:
      print("Unknown normal subcommand: '$subCommand'");
      print('Usage: clean_arch normal <init|feature> [name]');
      break;
  }
}

void _printUsage() {
  print('Usage:');
  print('  clean_arch init [clean|normal]');
  print('  clean_arch normal init');
  print('  clean_arch feature <name>');
  print('  clean_arch normal feature <name>');
}
