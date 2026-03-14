# clean_arch

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A command-line tool that scaffolds Flutter projects with either:

- **Clean Architecture** (layered `data/domain/presentation` feature modules), or
- **Normal Folder Architecture** (modular feature folders with
  `model/services/provider/screens`).

Run one command to initialize your project structure, then generate feature
modules as your app grows.

## Installation

```bash
dart pub global activate clean_arch
```

Make sure `~/.pub-cache/bin` (or `%APPDATA%\Pub\Cache\bin` on Windows) is on
your `PATH`.

## Usage

### Initialise architecture

Run this once at the root of your Flutter project:

```bash
clean_arch init
```

The CLI now prompts you to choose:

1. Clean Architecture
2. Normal Folder Architecture

You can also skip the prompt:

```bash
clean_arch init clean
clean_arch init normal
clean_arch normal init
```

Generated structure for **Clean Architecture**:

```
lib/
  core/
    config/           → app_config.dart
    constants/        → app_constants.dart
    data/
      datasources/
        local/        → local_datasource.dart
        remote/       → remote_datasource.dart
      models/
      repositories/   → base_repository.dart
    di/               → injection_container.dart
    errors/           → failures.dart, exceptions.dart
    network/
      interceptors/   → auth_interceptor.dart
    usecases/         → usecase.dart
    utils/            → extensions.dart
    route/            → app_router.dart
    storage/          → local_storage.dart
    services/         → api_service.dart
    shared/
      widgets/        → custom_button.dart
      mixins/         → validation_mixin.dart
    theme/            → app_theme.dart
  features/
```

Generated structure for **Normal Folder Architecture**:

```
lib/
  core/
    widgets/
      app_button.dart
    utils/
      app_utils.dart
    controllers/
      app_controller.dart
    helper/
      app_helper.dart
    services/
      app_service.dart
    theme/
      app_theme.dart
  features/
    auth/
      model/
        auth_model.dart
      services/
        auth_service.dart
      provider/
        auth_provider.dart
      screens/
        auth_screen.dart
    home/
      model/
        home_model.dart
      services/
        home_service.dart
      provider/
        home_provider.dart
      screens/
        home_screen.dart
```

Note: `clean_arch init normal` does not generate `main.dart` or `app.dart`
because Flutter already creates them when you create a new app.

### Generate a feature module

```bash
clean_arch feature <name>
```

Explicit normal architecture feature command:

```bash
clean_arch normal feature <name>
```

Example (auto-detect mode):

```bash
clean_arch feature auth
```

`clean_arch feature <name>` now works for both architecture styles:

- In a Clean Architecture project, it creates `data/domain/presentation` layers.
- In a Normal Folder project, it creates:
  - `screens/<name>_screen.dart`
  - `services/<name>_service.dart`
  - `provider/<name>_provider.dart`
  - `model/<name>_model.dart`

Use `clean_arch normal feature <name>` when you want to force normal feature
generation even if clean architecture files exist in the project.

Generated structure for `auth`:

(Clean Architecture mode)

```
lib/features/auth/
  data/
    datasources/   → auth_remote_datasource.dart, auth_local_datasource.dart
    models/        → auth_model.dart
    repositories/  → auth_repository_impl.dart
  domain/
    entities/      → auth_entity.dart
    repositories/  → auth_repository.dart
    usecases/      → get_auth_usecase.dart
  presentation/
    bloc/          → auth_bloc.dart, auth_event.dart, auth_state.dart
    pages/         → auth_page.dart
    widgets/       → auth_card.dart
```

(Normal Folder mode)

```
lib/features/auth/
  model/
    auth_model.dart
  services/
    auth_service.dart
  provider/
    auth_provider.dart
  screens/
    auth_screen.dart
```

## Programmatic API

You can also call the generators directly from Dart code:

```dart
import 'package:clean_arch/generators/architecture_generator.dart';
import 'package:clean_arch/generators/feature_generator.dart';

void main(List<String> args) {
  final useNormalArchitecture = args.contains('--normal');

  if (useNormalArchitecture) {
    generateStandardArchitecture();
    generateFeature('profile', architectureType: 'normal');
  } else {
    generateArchitecture();
    generateFeature('auth', architectureType: 'clean');
  }
}
```

See the [`example/`](example/main.dart) directory for a runnable sample.

## Requirements

- Dart SDK `>=3.8.1`
- Run from the **root of your Flutter project** so files are created at the
  correct `lib/` path.

## Author

Developed by **Abhishek Sharma**

- Portfolio: [abhishek-sharma.com.np](https://www.abhishek-sharma.com.np/)
- GitHub: [@4bhisheksharma](https://github.com/4bhisheksharma)

## Contributing

Pull requests are welcome!
See [CONTRIBUTING](https://github.com/4bhisheksharma/clean_arch/blob/main/CONTRIBUTING.md)
or open an issue at the
[issue tracker](https://github.com/4bhisheksharma/clean_arch/issues).

## License

[MIT](LICENSE)
