import 'dart:io';

import '../utils/logger.dart';

/// Packages added to the host Flutter project's `pubspec.yaml` on `init`.
///
/// Names are passed to `flutter pub add` without version constraints so pub
/// resolves the latest versions compatible with the project's SDK.
const List<String> defaultDependencies = [
  'flutter_bloc',
  'flutter_svg',
  'internet_connection_checker_plus',
  'pinput',
  'url_launcher',
  'shimmer',
  'nepali_date_picker',
  'share_plus',
  'path_provider',
  'http_parser',
  'image_picker',
  'dio',
  'file_picker',
  'flutter_dotenv',
  'socket_io_client',
  'connectivity_plus',
  'flutter_secure_storage',
  'get_it',
  'intl',
  'equatable',
  'latlong2',
  'open_filex',
  'shared_preferences',
  'in_app_update',
  'cached_network_image',
];

/// Runs [executable] with [arguments] and returns the result.
///
/// Injectable so tests can stub out the real `flutter` process.
typedef ProcessRunner =
    ProcessResult Function(String executable, List<String> arguments);

ProcessResult _defaultRunner(String executable, List<String> arguments) =>
    Process.runSync(executable, arguments, runInShell: true);

/// Adds [packages] to the Flutter project in the current directory with
/// `flutter pub add`.
///
/// All packages are added in a single call first. If that fails (for example
/// because one package cannot be resolved), each package is retried on its
/// own so one bad package does not block the rest.
///
/// Returns `true` when every package was added. Does nothing and returns
/// `false` when no `pubspec.yaml` exists in the current directory.
bool installDependencies({
  List<String> packages = defaultDependencies,
  ProcessRunner runner = _defaultRunner,
}) {
  if (!File('pubspec.yaml').existsSync()) {
    logWarning(
      'No pubspec.yaml found in the current directory. '
      'Skipping dependency installation.',
    );
    return false;
  }

  if (packages.isEmpty) {
    return true;
  }

  logInfo('Adding ${packages.length} packages with `flutter pub add`...');

  final ProcessResult batch;
  try {
    batch = runner('flutter', ['pub', 'add', ...packages]);
  } on ProcessException catch (e) {
    logError(
      'Could not run `flutter` (${e.message}). Make sure the Flutter SDK is '
      'on your PATH, then run:\n  flutter pub add ${packages.join(' ')}',
    );
    return false;
  }

  if (batch.exitCode == 0) {
    logSuccess('Dependencies added to pubspec.yaml.');
    return true;
  }

  logWarning('Adding all packages at once failed. Retrying one by one...');

  final failed = <String>[];
  for (final package in packages) {
    final result = runner('flutter', ['pub', 'add', package]);
    if (result.exitCode == 0) {
      logCreate('dependency  $package');
    } else {
      failed.add(package);
      logError('Failed to add $package:\n${result.stderr}'.trimRight());
    }
  }

  if (failed.isEmpty) {
    logSuccess('Dependencies added to pubspec.yaml.');
    return true;
  }

  logWarning(
    'Some packages could not be added: ${failed.join(', ')}. '
    'Add them manually with `flutter pub add <package>`.',
  );
  return false;
}
