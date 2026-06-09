## 1.0.3

- Added `route/app_router.dart` and `storage/app_storage.dart` to the **Normal
  Folder Architecture** core so it now matches the Clean Architecture core
  (which already shipped `route` and `storage`).
- Hardened the CLI:
  - New `clean_arch help` (`--help`/`-h`) and `clean_arch version`
    (`--version`/`-v`) commands.
  - Proper non-zero exit codes on usage errors.
  - Feature names are validated and auto-normalized to `snake_case`
    (e.g. `"User Profile"` → `user_profile`); invalid names are rejected.
- Improved console logging: ANSI colors (auto-detected), errors/warnings routed
  to `stderr`, and "skipped (already exists)" notices when files are not
  overwritten.
- `createFile`/`createDirectory` now return whether they created something.
- Added a `packageVersion` constant and exported the new `naming` utilities.
- Expanded the test suite (core scaffold coverage + name normalization).

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
