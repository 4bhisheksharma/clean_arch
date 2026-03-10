// ── Core templates (used by `init` command) ──

const String appConfigTemplate = '''
class AppConfig {
  static const String appName = 'MyApp';
  static const String baseUrl = 'https://api.example.com';
}
''';

const String appConstantsTemplate = '''
class AppConstants {
  static const int defaultPageSize = 20;
  static const Duration timeoutDuration = Duration(seconds: 30);
}
''';

const String localDatasourceTemplate = '''
abstract class LocalDatasource {
  Future<void> cacheData(String key, String value);
  Future<String?> getCachedData(String key);
}
''';

const String remoteDatasourceTemplate = '''
abstract class RemoteDatasource {
  Future<Map<String, dynamic>> get(String endpoint);
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body);
}
''';

const String baseRepositoryTemplate = '''
abstract class BaseRepository<T> {
  Future<List<T>> getAll();
  Future<T?> getById(String id);
}
''';

const String injectionContainerTemplate = '''
// Register your dependencies here.
// Example with get_it:
//   final sl = GetIt.instance;
//   void init() { sl.registerLazySingleton(() => MyService()); }

void initDependencies() {
  // TODO: register dependencies
}
''';

const String failuresTemplate = '''
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache error']) : super(message);
}
''';

const String exceptionsTemplate = '''
class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Server exception']);
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Cache exception']);
}
''';

const String authInterceptorTemplate = '''
// Example HTTP interceptor for authentication.
// Adapt to your HTTP client (dio, http, etc.).

class AuthInterceptor {
  final String? token;
  AuthInterceptor({this.token});

  Map<String, String> get headers => {
    if (token != null) 'Authorization': 'Bearer \$token',
  };
}
''';

const String usecaseTemplate = '''
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class NoParams {
  const NoParams();
}
''';

const String extensionsTemplate = '''
extension StringExtensions on String {
  String get capitalized =>
      isEmpty ? this : '\${this[0].toUpperCase()}\${substring(1)}';
}
''';

const String appRouterTemplate = '''
// Define your app routes here.

class AppRouter {
  static const String home = '/';
  static const String login = '/login';
  // Add more routes as needed.
}
''';

const String localStorageTemplate = '''
// Local storage abstraction.

abstract class LocalStorage {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
}
''';

const String apiServiceTemplate = '''
// Base API service – implement with your preferred HTTP client.

abstract class ApiService {
  Future<dynamic> get(String endpoint);
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body});
  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body});
  Future<dynamic> delete(String endpoint);
}
''';

const String customButtonTemplate = '''
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
''';

const String validationMixinTemplate = '''
mixin ValidationMixin {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!value.contains('@')) return 'Enter a valid email';
    return null;
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) return '\$fieldName is required';
    return null;
  }
}
''';

const String appThemeTemplate = '''
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
  );

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
  );
}
''';

// ── Feature templates (used by `feature` command) ──

String featureEntityTemplate(String name) => '''
class ${_pascal(name)}Entity {
  final String id;

  const ${_pascal(name)}Entity({required this.id});
}
''';

String featureModelTemplate(String name) => '''
import '../../domain/entities/${name}_entity.dart';

class ${_pascal(name)}Model extends ${_pascal(name)}Entity {
  const ${_pascal(name)}Model({required super.id});

  factory ${_pascal(name)}Model.fromJson(Map<String, dynamic> json) {
    return ${_pascal(name)}Model(id: json['id'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id};
}
''';

String featureRepositoryTemplate(String name) => '''
import '../entities/${name}_entity.dart';

abstract class ${_pascal(name)}Repository {
  Future<List<${_pascal(name)}Entity>> getAll();
  Future<${_pascal(name)}Entity?> getById(String id);
}
''';

String featureRepositoryImplTemplate(String name) => '''
import '../../domain/entities/${name}_entity.dart';
import '../../domain/repositories/${name}_repository.dart';

class ${_pascal(name)}RepositoryImpl implements ${_pascal(name)}Repository {
  @override
  Future<List<${_pascal(name)}Entity>> getAll() async {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<${_pascal(name)}Entity?> getById(String id) async {
    // TODO: implement getById
    throw UnimplementedError();
  }
}
''';

String featureRemoteDatasourceTemplate(String name) => '''
abstract class ${_pascal(name)}RemoteDatasource {
  Future<List<Map<String, dynamic>>> fetchAll();
}
''';

String featureLocalDatasourceTemplate(String name) => '''
abstract class ${_pascal(name)}LocalDatasource {
  Future<void> cacheData(List<Map<String, dynamic>> data);
  Future<List<Map<String, dynamic>>> getCachedData();
}
''';

String featureUsecaseTemplate(String name) => '''
import '../../../../core/usecases/usecase.dart';
import '../entities/${name}_entity.dart';
import '../repositories/${name}_repository.dart';

class Get${_pascal(name)} implements UseCase<List<${_pascal(name)}Entity>, NoParams> {
  final ${_pascal(name)}Repository repository;

  Get${_pascal(name)}(this.repository);

  @override
  Future<List<${_pascal(name)}Entity>> call(NoParams params) {
    return repository.getAll();
  }
}
''';

String featureBlocTemplate(String name) => '''
import '${name}_event.dart';
import '${name}_state.dart';

class ${_pascal(name)}Bloc {
  ${_pascal(name)}State _state = ${_pascal(name)}Initial();

  ${_pascal(name)}State get state => _state;

  void add(${_pascal(name)}Event event) {
    // TODO: handle events and emit states
  }
}
''';

String featureEventTemplate(String name) => '''
abstract class ${_pascal(name)}Event {}

class Load${_pascal(name)} extends ${_pascal(name)}Event {}
''';

String featureStateTemplate(String name) => '''
abstract class ${_pascal(name)}State {}

class ${_pascal(name)}Initial extends ${_pascal(name)}State {}

class ${_pascal(name)}Loading extends ${_pascal(name)}State {}

class ${_pascal(name)}Loaded extends ${_pascal(name)}State {
  final List<dynamic> items;
  ${_pascal(name)}Loaded(this.items);
}

class ${_pascal(name)}Error extends ${_pascal(name)}State {
  final String message;
  ${_pascal(name)}Error(this.message);
}
''';

String featurePageTemplate(String name) => '''
import 'package:flutter/material.dart';

class ${_pascal(name)}Page extends StatelessWidget {
  const ${_pascal(name)}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('${_pascal(name)}')),
      body: const Center(child: Text('${_pascal(name)} Page')),
    );
  }
}
''';

String featureWidgetTemplate(String name) => '''
import 'package:flutter/material.dart';

class ${_pascal(name)}Card extends StatelessWidget {
  const ${_pascal(name)}Card({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('${_pascal(name)} Card'),
      ),
    );
  }
}
''';

// ── Helpers ──

String _pascal(String input) {
  return input
      .split('_')
      .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
      .join();
}
