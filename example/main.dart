// This example shows how to use clean_arch programmatically.
//
// In normal use you run the tool from the command line:
//
//   dart pub global activate clean_arch
//
//   # Scaffold the full core layer inside the current Flutter project:
//   clean_arch init
//
//   # Generate a feature module called "auth":
//   clean_arch feature auth

import 'package:clean_arch/generators/architecture_generator.dart';
import 'package:clean_arch/generators/feature_generator.dart';

void main() {
  // Generate the base Clean Architecture skeleton.
  // Creates lib/core/** with starter files for config, DI, errors, theme, etc.
  generateArchitecture();

  // Generate a feature module.
  // Creates lib/features/auth/** with entity, model, repository,
  // datasources, usecase, bloc, page, and widget files.
  generateFeature('auth');
}
