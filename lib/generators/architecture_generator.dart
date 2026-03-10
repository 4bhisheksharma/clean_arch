import '../utils/file_helper.dart';
import '../utils/logger.dart';

void generateArchitecture() {

  logInfo("Initializing Clean Architecture...");

  createDirectory("lib/core/config");
  createDirectory("lib/core/constants");
  createDirectory("lib/core/data/datasources/local");
  createDirectory("lib/core/data/datasources/remote");
  createDirectory("lib/core/data/models");
  createDirectory("lib/core/data/repositories");
  createDirectory("lib/core/di");
  createDirectory("lib/core/errors");
  createDirectory("lib/core/network/interceptors");
  createDirectory("lib/core/usecases");
  createDirectory("lib/core/utils");
  createDirectory("lib/core/route");
  createDirectory("lib/core/storage");
  createDirectory("lib/core/services");
  createDirectory("lib/core/shared/widgets");
  createDirectory("lib/core/shared/mixins");
  createDirectory("lib/core/theme");

  createDirectory("lib/features");

  logSuccess("Clean architecture initialized.");
}