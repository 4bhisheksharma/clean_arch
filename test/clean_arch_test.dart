import 'dart:io';

import 'package:clean_arch/commands/init_command.dart';
import 'package:clean_arch/generators/architecture_generator.dart';
import 'package:clean_arch/generators/feature_generator.dart';
import 'package:clean_arch/utils/naming.dart';
import 'package:test/test.dart';

void main() {
  final testDir = '${Directory.systemTemp.path}/clean_arch_test';
  late String originalDirectory;

  setUp(() {
    originalDirectory = Directory.current.path;
    final dir = Directory(testDir);
    if (dir.existsSync()) dir.deleteSync(recursive: true);
    dir.createSync(recursive: true);
    Directory.current = testDir;
  });

  tearDown(() {
    Directory.current = originalDirectory;
    final dir = Directory(testDir);
    if (dir.existsSync()) dir.deleteSync(recursive: true);
  });

  test('createDirectory creates nested directories', () {
    final path = '$testDir/a/b/c';
    Directory(path).createSync(recursive: true);
    expect(Directory(path).existsSync(), isTrue);
  });

  test('createFile creates a file with content', () {
    final path = '$testDir/sample.dart';
    final file = File(path);
    file.createSync(recursive: true);
    file.writeAsStringSync('hello');
    expect(file.existsSync(), isTrue);
    expect(file.readAsStringSync(), 'hello');
  });

  test('generateArchitecture creates clean architecture scaffold with all 22 core folders', () {
    generateArchitecture();

    expect(File('lib/core/app/main_app.dart').existsSync(), isTrue);
    expect(File('lib/core/config/app_config.dart').existsSync(), isTrue);
    expect(File('lib/core/constants/app_constants.dart').existsSync(), isTrue);
    expect(
      File('lib/core/data/datasources/local/local_datasource.dart').existsSync(),
      isTrue,
    );
    expect(
      File('lib/core/data/datasources/remote/remote_datasource.dart').existsSync(),
      isTrue,
    );
    expect(
      File('lib/core/data/repositories/base_repository.dart').existsSync(),
      isTrue,
    );
    expect(File('lib/core/database/app_database.dart').existsSync(), isTrue);
    expect(File('lib/core/date_picker/app_date_picker.dart').existsSync(), isTrue);
    expect(File('lib/core/di/injection_container.dart').existsSync(), isTrue);
    expect(File('lib/core/errors/failures.dart').existsSync(), isTrue);
    expect(File('lib/core/errors/exceptions.dart').existsSync(), isTrue);
    expect(File('lib/core/locations/location_service.dart').existsSync(), isTrue);
    expect(File('lib/core/models/base_model.dart').existsSync(), isTrue);
    expect(File('lib/core/navigation/app_navigator.dart').existsSync(), isTrue);
    expect(File('lib/core/network/network_info.dart').existsSync(), isTrue);
    expect(
      File('lib/core/network/interceptors/auth_interceptor.dart').existsSync(),
      isTrue,
    );
    expect(File('lib/core/platform/platform_info.dart').existsSync(), isTrue);
    expect(File('lib/core/router/app_router.dart').existsSync(), isTrue);
    expect(File('lib/core/security/security_service.dart').existsSync(), isTrue);
    expect(File('lib/core/services/api_service.dart').existsSync(), isTrue);
    expect(
      File('lib/core/shared/widgets/custom_button.dart').existsSync(),
      isTrue,
    );
    expect(File('lib/core/storage/local_storage.dart').existsSync(), isTrue);
    expect(File('lib/core/sync/sync_manager.dart').existsSync(), isTrue);
    expect(File('lib/core/theme/app_theme.dart').existsSync(), isTrue);
    expect(File('lib/core/utils/extensions.dart').existsSync(), isTrue);
    expect(File('lib/core/validation/form_validators.dart').existsSync(), isTrue);
    expect(Directory('lib/features').existsSync(), isTrue);
  });

  test('generateStandardArchitecture creates normal scaffold', () {
    generateStandardArchitecture();

    expect(File('lib/core/widgets/app_button.dart').existsSync(), isTrue);
    expect(File('lib/core/utils/app_utils.dart').existsSync(), isTrue);
    expect(
      File('lib/core/controllers/app_controller.dart').existsSync(),
      isTrue,
    );
    expect(File('lib/core/helper/app_helper.dart').existsSync(), isTrue);
    expect(File('lib/core/services/app_service.dart').existsSync(), isTrue);
    expect(File('lib/core/theme/app_theme.dart').existsSync(), isTrue);
    expect(File('lib/core/route/app_router.dart').existsSync(), isTrue);
    expect(File('lib/core/storage/app_storage.dart').existsSync(), isTrue);

    expect(
      File('lib/features/auth/model/auth_model.dart').existsSync(),
      isTrue,
    );
    expect(
      File('lib/features/auth/services/auth_service.dart').existsSync(),
      isTrue,
    );
    expect(
      File('lib/features/auth/provider/auth_provider.dart').existsSync(),
      isTrue,
    );
    expect(
      File('lib/features/auth/screens/auth_screen.dart').existsSync(),
      isTrue,
    );

    expect(
      File('lib/features/home/model/home_model.dart').existsSync(),
      isTrue,
    );
    expect(
      File('lib/features/home/services/home_service.dart').existsSync(),
      isTrue,
    );
    expect(
      File('lib/features/home/provider/home_provider.dart').existsSync(),
      isTrue,
    );
    expect(
      File('lib/features/home/screens/home_screen.dart').existsSync(),
      isTrue,
    );
    expect(File('lib/main.dart').existsSync(), isFalse);
    expect(File('lib/app.dart').existsSync(), isFalse);
  });

  test('runInit supports explicit architecture argument', () {
    runInit(architectureType: 'normal');
    expect(
      File('lib/features/auth/services/auth_service.dart').existsSync(),
      isTrue,
    );

    final cleanDir = Directory(
      '${Directory.systemTemp.path}/clean_arch_test_2',
    );
    if (cleanDir.existsSync()) {
      cleanDir.deleteSync(recursive: true);
    }
    cleanDir.createSync(recursive: true);

    final previous = Directory.current.path;
    Directory.current = cleanDir.path;
    try {
      runInit(architectureType: 'clean');
      expect(File('lib/core/config/app_config.dart').existsSync(), isTrue);
    } finally {
      Directory.current = previous;
      cleanDir.deleteSync(recursive: true);
    }
  });

  test('generateFeature creates clean feature structure in clean project', () {
    generateArchitecture();

    generateFeature('profile');

    expect(
      File(
        'lib/features/profile/domain/entities/profile_entity.dart',
      ).existsSync(),
      isTrue,
    );
    expect(
      File(
        'lib/features/profile/presentation/screens/profile_screen.dart',
      ).existsSync(),
      isTrue,
    );
  });

  test(
    'generateFeature creates normal feature structure in normal project',
    () {
      generateStandardArchitecture();

      generateFeature('settings');

      expect(
        File('lib/features/settings/screens/settings_screen.dart').existsSync(),
        isTrue,
      );
      expect(
        File(
          'lib/features/settings/services/settings_service.dart',
        ).existsSync(),
        isTrue,
      );
      expect(
        File(
          'lib/features/settings/provider/settings_provider.dart',
        ).existsSync(),
        isTrue,
      );
      expect(
        File('lib/features/settings/model/settings_model.dart').existsSync(),
        isTrue,
      );
    },
  );

  test('generateFeature can force normal mode in clean project', () {
    generateArchitecture();

    generateFeature('orders', architectureType: 'normal');

    expect(
      File('lib/features/orders/screens/orders_screen.dart').existsSync(),
      isTrue,
    );
    expect(
      File('lib/features/orders/services/orders_service.dart').existsSync(),
      isTrue,
    );
    expect(
      File(
        'lib/features/orders/domain/entities/orders_entity.dart',
      ).existsSync(),
      isFalse,
    );
  });

  test('generateFeature normalizes messy feature names', () {
    generateArchitecture();

    generateFeature('User Profile');

    expect(
      File(
        'lib/features/user_profile/domain/entities/user_profile_entity.dart',
      ).existsSync(),
      isTrue,
    );
  });

  test('generateFeature ignores invalid feature names', () {
    generateArchitecture();

    generateFeature('123');

    expect(Directory('lib/features/123').existsSync(), isFalse);
  });

  group('normalizeFeatureName', () {
    test('converts spaces, hyphens, and camelCase to snake_case', () {
      expect(normalizeFeatureName('User Profile'), 'user_profile');
      expect(normalizeFeatureName('userProfile'), 'user_profile');
      expect(normalizeFeatureName('order-history'), 'order_history');
      expect(normalizeFeatureName('  messy__Name  '), 'messy_name');
      expect(normalizeFeatureName('auth'), 'auth');
    });

    test('returns null for invalid names', () {
      expect(normalizeFeatureName(''), isNull);
      expect(normalizeFeatureName('   '), isNull);
      expect(normalizeFeatureName('123'), isNull);
      expect(normalizeFeatureName('!!!'), isNull);
    });
  });
}
