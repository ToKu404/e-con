// ignore_for_file: depend_on_referenced_packages

import 'package:e_con/core/common/auth_preference_helper.dart';
import 'package:e_con/src/data/datasources/auth_datasource.dart';
import 'package:e_con/src/data/datasources/profile_datasource.dart';
import 'package:e_con/src/data/repositories/auth_repository_impl.dart';
import 'package:e_con/src/data/repositories/profile_repository_impl.dart';
import 'package:e_con/src/domain/repositories/auth_repository.dart';
import 'package:e_con/src/domain/repositories/profile_repository.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_lecture_data.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_student_data.dart';
import 'package:e_con/src/domain/usecases/user_usecases/get_user.dart';
import 'package:e_con/src/domain/usecases/user_usecases/log_out.dart';
import 'package:e_con/src/domain/usecases/user_usecases/sign_in.dart';
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:e_con/src/presentations/features/login/provider/get_user_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/lecture_profile_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // Repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      profileDataSource: locator(),
    ),
  );

  // Datasource
  locator.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(
      client: locator(),
      authPreferenceHelper: locator(),
    ),
  );

  locator.registerLazySingleton<ProfileDataSource>(
    () => ProfileDataSourceImpl(
      client: locator(),
      authPreferenceHelper: locator(),
    ),
  );

  // Usercase
  locator.registerLazySingleton(
    () => SignIn(
      authRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetUser(
      authRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => LogOut(
      authRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetStudentData(
      profileRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetLectureData(
      profileRepository: locator(),
    ),
  );

  // Provider
  locator.registerFactory(
    () => GetUserNotifier(
      getUserUsecase: locator(),
    ),
  );
  locator.registerFactory(
    () => AuthNotifier(
      logOutUsecase: locator(),
      signInUsecase: locator(),
    ),
  );
  locator.registerFactory(
    () => StudentProfileNotifier(
      getStudentDataUsecase: locator(),
    ),
  );
  locator.registerFactory(
    () => LectureProfileNotifier(
      getLectureDataUsecase: locator(),
    ),
  );

  // client w/ SSL pinning certified
  locator.registerLazySingleton(() => http.Client());

  // external
  locator.registerLazySingleton<AuthPreferenceHelper>(
      () => AuthPreferenceHelper());
}
