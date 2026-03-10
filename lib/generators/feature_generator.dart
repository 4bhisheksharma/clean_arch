import '../templates/templates.dart';
import '../utils/file_helper.dart';
import '../utils/logger.dart';

/// Scaffolds a complete Clean Architecture feature module named [feature]
/// inside `lib/features/[feature]/`.
///
/// Generates the `data`, `domain`, and `presentation` layers, each with
/// appropriate starter files.
void generateFeature(String feature) {
  logInfo("Generating feature: $feature");

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

  logSuccess("Feature '$feature' generated.");
}
