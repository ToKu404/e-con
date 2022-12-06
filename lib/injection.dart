// ignore_for_file: depend_on_referenced_packages

import 'package:e_con/src/data/datasources/auth_datasource.dart';
import 'package:e_con/src/data/repositories/auth_repository_impl.dart';
import 'package:e_con/src/domain/repositories/auth_repository.dart';
import 'package:e_con/src/domain/usecases/user_usecases/sign_in.dart';
import 'package:e_con/src/presentations/features/login/provider/login_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SignIn(
      authRepository: locator(),
    ),
  );

  locator.registerFactory(
    () => LoginNotifier(
      signInUsecase: locator(),
    ),
  );
  // client w/ SSL pinning certified
  locator.registerLazySingleton(() => http.Client());
}
