import '../templates/templates.dart';
import 'feature_generator.dart';
import '../utils/file_helper.dart';
import '../utils/logger.dart';

/// Scaffolds the full Clean Architecture core layer inside `lib/core/`.
///
/// Creates every standard sub-directory and writes a starter `.dart` file
/// into each one so the directories are never empty.
void generateArchitecture() {
  logInfo("Initializing Clean Architecture...");

  createDirectoryWithFile(
    "lib/core/config",
    "app_config.dart",
    appConfigTemplate,
  );
  createDirectoryWithFile(
    "lib/core/constants",
    "app_constants.dart",
    appConstantsTemplate,
  );
  createDirectoryWithFile(
    "lib/core/data/datasources/local",
    "local_datasource.dart",
    localDatasourceTemplate,
  );
  createDirectoryWithFile(
    "lib/core/data/datasources/remote",
    "remote_datasource.dart",
    remoteDatasourceTemplate,
  );
  createDirectory("lib/core/data/models");
  createDirectoryWithFile(
    "lib/core/data/repositories",
    "base_repository.dart",
    baseRepositoryTemplate,
  );
  createDirectoryWithFile(
    "lib/core/di",
    "injection_container.dart",
    injectionContainerTemplate,
  );
  createDirectoryWithFile("lib/core/errors", "failures.dart", failuresTemplate);
  createDirectoryWithFile(
    "lib/core/errors",
    "exceptions.dart",
    exceptionsTemplate,
  );
  createDirectoryWithFile(
    "lib/core/network/interceptors",
    "auth_interceptor.dart",
    authInterceptorTemplate,
  );
  createDirectoryWithFile("lib/core/usecases", "usecase.dart", usecaseTemplate);
  createDirectoryWithFile(
    "lib/core/utils",
    "extensions.dart",
    extensionsTemplate,
  );
  createDirectoryWithFile(
    "lib/core/route",
    "app_router.dart",
    appRouterTemplate,
  );
  createDirectoryWithFile(
    "lib/core/storage",
    "local_storage.dart",
    localStorageTemplate,
  );
  createDirectoryWithFile(
    "lib/core/services",
    "api_service.dart",
    apiServiceTemplate,
  );
  createDirectoryWithFile(
    "lib/core/shared/widgets",
    "custom_button.dart",
    customButtonTemplate,
  );
  createDirectoryWithFile(
    "lib/core/shared/mixins",
    "validation_mixin.dart",
    validationMixinTemplate,
  );
  createDirectoryWithFile("lib/core/theme", "app_theme.dart", appThemeTemplate);

  createDirectory("lib/features");

  logSuccess("Clean architecture initialized.");
}

/// Scaffolds a standard Flutter folder architecture inside `lib/`.
///
/// Creates shared `core` and starter `features` modules.
void generateStandardArchitecture() {
  logInfo('Initializing Normal Folder Architecture...');

  createDirectoryWithFile(
    'lib/core/widgets',
    'app_button.dart',
    standardCoreWidgetTemplate,
  );
  createDirectoryWithFile(
    'lib/core/utils',
    'app_utils.dart',
    standardCoreUtilsTemplate,
  );
  createDirectoryWithFile(
    'lib/core/controllers',
    'app_controller.dart',
    standardCoreControllerTemplate,
  );
  createDirectoryWithFile(
    'lib/core/helper',
    'app_helper.dart',
    standardCoreHelperTemplate,
  );
  createDirectoryWithFile(
    'lib/core/services',
    'app_service.dart',
    standardCoreServiceTemplate,
  );
  createDirectoryWithFile(
    'lib/core/theme',
    'app_theme.dart',
    standardCoreThemeTemplate,
  );

  createDirectory('lib/features');
  generateFeature('auth', architectureType: 'normal');
  generateFeature('home', architectureType: 'normal');

  logSuccess('Normal folder architecture initialized.');
}
