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
