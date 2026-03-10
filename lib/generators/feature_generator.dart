import '../utils/file_helper.dart';
import '../utils/logger.dart';

void generateFeature(String feature) {

  logInfo("Generating feature: $feature");

  final base = "lib/features/$feature";

  createDirectory("$base/data/datasources");
  createDirectory("$base/data/models");
  createDirectory("$base/data/repositories");

  createDirectory("$base/domain/entities");
  createDirectory("$base/domain/repositories");
  createDirectory("$base/domain/usecases");

  createDirectory("$base/presentation/bloc");
  createDirectory("$base/presentation/pages");
  createDirectory("$base/presentation/widgets");

  logSuccess("Feature '$feature' generated.");
}