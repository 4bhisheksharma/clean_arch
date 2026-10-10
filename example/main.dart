// This example shows how to use clean_arch programmatically.
//
// In normal CLI usage:
//   clean_arch init
//   clean_arch normal init
//   clean_arch feature auth
//   clean_arch normal feature auth

import 'package:clean_arch/generators/architecture_generator.dart';
import 'package:clean_arch/generators/feature_generator.dart';

void main(List<String> args) {
  final useNormalArchitecture = args.contains('--normal');

  if (useNormalArchitecture) {
    // Creates core/widgets, core/utils, core/controllers, core/helper,
    // core/services, core/theme and starter auth/home feature folders.
    generateStandardArchitecture();

    // Creates features/profile/{model,services,provider,screens}/...
    generateFeature('profile', architectureType: 'normal');
  } else {
    // Creates clean architecture core structure.
    generateArchitecture();

    // Creates clean architecture feature layers.
    generateFeature('auth', architectureType: 'clean');
  }
}
