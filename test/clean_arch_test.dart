import 'dart:io';

import 'package:clean_arch/commands/init_command.dart';
import 'package:clean_arch/generators/architecture_generator.dart';
import 'package:clean_arch/generators/feature_generator.dart';
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

  test('generateArchitecture creates clean architecture scaffold', () {
    generateArchitecture();

    expect(File('lib/core/config/app_config.dart').existsSync(), isTrue);
    expect(File('lib/core/usecases/usecase.dart').existsSync(), isTrue);
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
}
