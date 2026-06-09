import 'dart:io';

import 'package:clean_arch/commands/feature_command.dart';
import 'package:clean_arch/commands/init_command.dart';
import 'package:clean_arch/src/version.dart';
import 'package:clean_arch/utils/logger.dart';
import 'package:clean_arch/utils/naming.dart';

const int _exitUsage = 64;

void main(List<String> args) {
  if (args.isEmpty) {
    _printUsage();
    exitCode = _exitUsage;
    return;
  }

  final command = args.first;

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

    case 'help':
    case '--help':
    case '-h':
      _printUsage();
      break;

    case 'version':
    case '--version':
    case '-v':
      logInfo('clean_arch $packageVersion');
      break;

    default:
      logError("Unknown command: '$command'");
      _printUsage();
      exitCode = _exitUsage;
      break;
  }
}

void _handleInit(List<String> args) {
  final architectureType = args.length >= 2 ? args[1] : null;
  runInit(architectureType: architectureType);
}

void _handleFeature(List<String> args) {
  if (args.length < 2) {
    logError('Missing feature name.');
    logInfo('Usage: clean_arch feature <name>');
    exitCode = _exitUsage;
    return;
  }

  if (!_runFeatureChecked(args[1])) {
    exitCode = _exitUsage;
  }
}

void _handleNormal(List<String> args) {
  if (args.length < 2) {
    logError('Missing normal subcommand.');
    logInfo('Usage: clean_arch normal <init|feature> [name]');
    exitCode = _exitUsage;
    return;
  }

  final subCommand = args[1];

  switch (subCommand) {
    case 'init':
      runNormalInit();
      break;
    case 'feature':
      if (args.length < 3) {
        logError('Missing feature name.');
        logInfo('Usage: clean_arch normal feature <name>');
        exitCode = _exitUsage;
        return;
      }
      if (!_runFeatureChecked(args[2], architectureType: 'normal')) {
        exitCode = _exitUsage;
      }
      break;
    default:
      logError("Unknown normal subcommand: '$subCommand'");
      logInfo('Usage: clean_arch normal <init|feature> [name]');
      exitCode = _exitUsage;
      break;
  }
}

/// Validates the feature [name] before delegating to the generator.
///
/// Returns `false` (and logs an error) when the name is invalid, so the caller
/// can set a non-zero exit code.
bool _runFeatureChecked(String name, {String? architectureType}) {
  if (normalizeFeatureName(name) == null) {
    logError(
      "Invalid feature name: '$name'. "
      'Use letters, digits, and underscores (e.g. user_profile).',
    );
    return false;
  }

  runFeature(name, architectureType: architectureType);
  return true;
}

void _printUsage() {
  logInfo('clean_arch $packageVersion — Flutter project scaffolder\n');
  logInfo('Usage:');
  logInfo('  clean_arch init [clean|normal]   Scaffold the core layer');
  logInfo('  clean_arch normal init           Scaffold the normal core layer');
  logInfo('  clean_arch feature <name>        Generate a feature module');
  logInfo('  clean_arch normal feature <name> Generate a normal feature module');
  logInfo('  clean_arch help                  Show this help message');
  logInfo('  clean_arch version               Show the installed version');
}
