# clean_arch

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A command-line tool that scaffolds Flutter projects following **Clean Architecture**.
Run one command to generate the full `core` layer, then generate feature modules
as your app grows — each with entity, model, repository, datasources, use-case,
BLoC, page, and widget files ready to fill in.

## Installation

```bash
dart pub global activate clean_arch
```

Make sure `~/.pub-cache/bin` (or `%APPDATA%\Pub\Cache\bin` on Windows) is on
your `PATH`.

## Usage

### Initialise the core layer

Run this once at the root of your Flutter project:

```bash
clean_arch init
```

Generated structure:

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

### Generate a feature module

```bash
clean_arch feature <name>
```

Example:

```bash
clean_arch feature auth
```

Generated structure for `auth`:

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

## Programmatic API

You can also call the generators directly from Dart code:

```dart
import 'package:clean_arch/generators/architecture_generator.dart';
import 'package:clean_arch/generators/feature_generator.dart';

void main() {
  generateArchitecture();
  generateFeature('auth');
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
