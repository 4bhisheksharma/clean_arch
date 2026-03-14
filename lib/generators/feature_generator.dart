import 'dart:io';

import '../templates/templates.dart';
import '../utils/file_helper.dart';
import '../utils/logger.dart';

/// Scaffolds a feature module named [feature] inside `lib/features/[feature]/`.
///
/// The generator auto-detects architecture mode from the existing project:
/// - Clean Architecture: creates data/domain/presentation layers.
/// - Normal Folder Architecture: creates screen/service/provider/model/widgets.
///
/// Pass [architectureType] as `clean` or `normal` to force a mode.
void generateFeature(String feature, {String? architectureType}) {
  final forcedMode = _normalizeArchitectureType(architectureType);

  if (forcedMode == _FeatureArchitectureType.clean ||
      (forcedMode == null && _isCleanArchitectureProject())) {
    _generateCleanFeature(feature);
    return;
  }

  _generateStandardFeature(feature);
}

void _generateCleanFeature(String feature) {
  logInfo("Generating feature: $feature (clean architecture)");

  final base = "lib/features/$feature";

  createDirectoryWithFile(
    "$base/data/datasources",
    "${feature}_remote_datasource.dart",
    featureRemoteDatasourceTemplate(feature),
  );
  createDirectoryWithFile(
    "$base/data/datasources",
    "${feature}_local_datasource.dart",
    featureLocalDatasourceTemplate(feature),
  );
  createDirectoryWithFile(
    "$base/data/models",
    "${feature}_model.dart",
    featureModelTemplate(feature),
  );
  createDirectoryWithFile(
    "$base/data/repositories",
    "${feature}_repository_impl.dart",
    featureRepositoryImplTemplate(feature),
  );

  createDirectoryWithFile(
    "$base/domain/entities",
    "${feature}_entity.dart",
    featureEntityTemplate(feature),
  );
  createDirectoryWithFile(
    "$base/domain/repositories",
    "${feature}_repository.dart",
    featureRepositoryTemplate(feature),
  );
  createDirectoryWithFile(
    "$base/domain/usecases",
    "get_${feature}_usecase.dart",
    featureUsecaseTemplate(feature),
  );

  createDirectoryWithFile(
    "$base/presentation/bloc",
    "${feature}_bloc.dart",
    featureBlocTemplate(feature),
  );
  createDirectoryWithFile(
    "$base/presentation/bloc",
    "${feature}_event.dart",
    featureEventTemplate(feature),
  );
  createDirectoryWithFile(
    "$base/presentation/bloc",
    "${feature}_state.dart",
    featureStateTemplate(feature),
  );
  createDirectoryWithFile(
    "$base/presentation/pages",
    "${feature}_page.dart",
    featurePageTemplate(feature),
  );
  createDirectoryWithFile(
    "$base/presentation/widgets",
    "${feature}_card.dart",
    featureWidgetTemplate(feature),
  );

  logSuccess("Feature '$feature' generated (clean architecture).");
}

void _generateStandardFeature(String feature) {
  logInfo("Generating feature: $feature (normal architecture)");

  final base = 'lib/features/$feature';

  createDirectoryWithFile(
    '$base/screens',
    '${feature}_screen.dart',
    standardFeatureScreenTemplate(feature),
  );
  createDirectoryWithFile(
    '$base/services',
    '${feature}_service.dart',
    standardFeatureServiceTemplate(feature),
  );
  createDirectoryWithFile(
    '$base/provider',
    '${feature}_provider.dart',
    standardFeatureProviderTemplate(feature),
  );
  createDirectoryWithFile(
    '$base/model',
    '${feature}_model.dart',
    standardFeatureModelTemplate(feature),
  );

  logSuccess("Feature '$feature' generated (normal architecture).");
}

bool _isCleanArchitectureProject() {
  return File('lib/core/config/app_config.dart').existsSync() ||
      File('lib/core/usecases/usecase.dart').existsSync() ||
      Directory('lib/core/data').existsSync();
}

_FeatureArchitectureType? _normalizeArchitectureType(String? input) {
  if (input == null) {
    return null;
  }

  switch (input.trim().toLowerCase()) {
    case 'clean':
    case 'clean-architecture':
    case 'clean_architecture':
      return _FeatureArchitectureType.clean;
    case 'normal':
    case 'standard':
    case 'folder':
    case 'normal-folder':
    case 'normal_folder':
      return _FeatureArchitectureType.normal;
    default:
      return null;
  }
}

enum _FeatureArchitectureType { clean, normal }
