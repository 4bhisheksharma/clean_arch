import 'dart:io';

import '../generators/architecture_generator.dart';
import '../generators/dependency_installer.dart' as deps;
import '../utils/logger.dart';

/// Runs the `init` command, scaffolding the selected architecture inside the
/// current working directory.
///
/// When [installDependencies] is `true` (the default), the packages in
/// [deps.defaultDependencies] are added to the project with `flutter pub add`.
void runInit({String? architectureType, bool installDependencies = true}) {
  final selectedArchitecture = _resolveArchitecture(architectureType);

  if (selectedArchitecture == _ArchitectureType.normal) {
    generateStandardArchitecture();
  } else {
    generateArchitecture();
  }

  if (installDependencies) {
    deps.installDependencies();
  }
}

/// Runs the `normal init` command alias.
void runNormalInit({bool installDependencies = true}) {
  runInit(architectureType: 'normal', installDependencies: installDependencies);
}

_ArchitectureType _resolveArchitecture(String? architectureType) {
  final normalized = _normalizeArchitectureInput(architectureType);
  if (normalized != null) {
    return normalized;
  }

  if (!stdin.hasTerminal) {
    logInfo(
      'No interactive terminal detected. Defaulting to Clean Architecture.',
    );
    return _ArchitectureType.clean;
  }

  logInfo('Choose project architecture:');
  logInfo('  1) Clean Architecture');
  logInfo('  2) Normal Folder Architecture');
  stdout.write('Enter choice (1/2, default: 1): ');

  final input = stdin.readLineSync();
  return _normalizeArchitectureInput(input) ?? _ArchitectureType.clean;
}

_ArchitectureType? _normalizeArchitectureInput(String? input) {
  if (input == null) {
    return null;
  }

  switch (input.trim().toLowerCase()) {
    case '1':
    case 'clean':
    case 'clean-architecture':
    case 'clean_architecture':
      return _ArchitectureType.clean;
    case '2':
    case 'normal':
    case 'standard':
    case 'folder':
    case 'normal-folder':
    case 'normal_folder':
      return _ArchitectureType.normal;
    default:
      return null;
  }
}

enum _ArchitectureType { clean, normal }
