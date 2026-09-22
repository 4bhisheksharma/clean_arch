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
    "lib/core/app",
    "main_app.dart",
    mainAppTemplate,
  );
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
  createDirectoryWithFile(
    "lib/core/data/repositories",
    "base_repository.dart",
    baseRepositoryTemplate,
  );
  createDirectoryWithFile(
    "lib/core/database",
    "app_database.dart",
    appDatabaseTemplate,
  );
  createDirectoryWithFile(
    "lib/core/date_picker",
    "app_date_picker.dart",
    appDatePickerTemplate,
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
    "lib/core/locations",
    "location_service.dart",
    locationServiceTemplate,
  );
  createDirectoryWithFile(
    "lib/core/models",
    "base_model.dart",
    baseModelTemplate,
  );
  createDirectoryWithFile(
    "lib/core/navigation",
    "app_navigator.dart",
    appNavigatorTemplate,
  );
  createDirectoryWithFile(
    "lib/core/network",
    "network_info.dart",
    networkInfoTemplate,
  );
  createDirectoryWithFile(
    "lib/core/network/interceptors",
    "auth_interceptor.dart",
    authInterceptorTemplate,
  );
  createDirectoryWithFile(
    "lib/core/platform",
    "platform_info.dart",
    platformInfoTemplate,
  );
  createDirectoryWithFile(
    "lib/core/router",
    "app_router.dart",
    appRouterTemplate,
  );
  createDirectoryWithFile(
    "lib/core/security",
    "security_service.dart",
    securityServiceTemplate,
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
    "lib/core/storage",
    "local_storage.dart",
    localStorageTemplate,
  );
  createDirectoryWithFile(
    "lib/core/sync",
    "sync_manager.dart",
    syncManagerTemplate,
  );
  createDirectoryWithFile("lib/core/theme", "app_theme.dart", appThemeTemplate);
  createDirectoryWithFile(
    "lib/core/utils",
    "extensions.dart",
    extensionsTemplate,
  );
  createDirectoryWithFile(
    "lib/core/validation",
    "form_validators.dart",
    formValidatorsTemplate,
  );

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
  createDirectoryWithFile(
    'lib/core/route',
    'app_router.dart',
    standardCoreRouterTemplate,
  );
  createDirectoryWithFile(
    'lib/core/storage',
    'app_storage.dart',
    standardCoreStorageTemplate,
  );

  createDirectory('lib/features');
  generateFeature('auth', architectureType: 'normal');
  generateFeature('home', architectureType: 'normal');

  logSuccess('Normal folder architecture initialized.');
}
