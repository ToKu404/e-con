// ignore_for_file: depend_on_referenced_packages

import 'package:e_con/core/dependency_injection/inject_datasource.dart';
import 'package:e_con/core/dependency_injection/inject_external_resources.dart';
import 'package:e_con/core/dependency_injection/inject_provider.dart';
import 'package:e_con/core/dependency_injection/inject_repository.dart';
import 'package:e_con/core/dependency_injection/inject_usecases.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  injectRepository(locator);

  injectDatasource(locator);

  injectUsecases(locator);

  injectProvider(locator);

  injectExternalResources(locator);
}
