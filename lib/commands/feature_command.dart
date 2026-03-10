import '../generators/feature_generator.dart';

/// Runs the `feature` command, scaffolding a complete feature module
/// named [feature] inside `lib/features/`.
void runFeature(String feature) {
  generateFeature(feature);
}
