## 1.0.2
- Changed directiory name from pages to screens and same for files.

## 1.0.1

- Added `clean_arch normal init` as an explicit alias for normal architecture
  initialization.
- Refactored CLI command routing into modular handlers to keep command parsing
  easier to maintain and extend.
- Refined normal architecture scaffolding to generate:
  - `lib/core/widgets`, `lib/core/utils`, `lib/core/controllers`,
    `lib/core/helper`, `lib/core/services`, `lib/core/theme`
  - starter `auth` and `home` features with nested
    `model/services/provider/screens` folders.
- Updated `clean_arch normal feature <name>` to generate nested
  `model/services/provider/screens` folders and starter boilerplate files.
- Updated programmatic example to demonstrate both clean and normal
  architecture generation paths.


## 1.0.0

- Initial stable release.
- `clean_arch init` scaffolds the full Clean Architecture core layer with
  starter files for config, constants, DI, errors, network, usecases, utils,
  route, storage, services, shared widgets/mixins, and theme.
- `clean_arch feature <name>` generates a complete feature module with entity,
  model, repository, datasources, use-case, BLoC (bloc/event/state), page, and
  widget boilerplate.
- Programmatic API via `package:clean_arch/generators/architecture_generator.dart`
  and `package:clean_arch/generators/feature_generator.dart`.
