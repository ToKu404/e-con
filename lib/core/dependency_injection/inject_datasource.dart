import 'package:e_con/src/data/datasources/attendance_datasource.dart';
import 'package:e_con/src/data/datasources/auth_datasource.dart';
import 'package:e_con/src/data/datasources/cpl_lecturer_datasource.dart';
import 'package:e_con/src/data/datasources/cpl_student_datasource.dart';
import 'package:e_con/src/data/datasources/profile_datasource.dart';
import 'package:get_it/get_it.dart';

void injectDatasource(GetIt locator) {
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
  locator.registerLazySingleton<CplLecturerDataSource>(
    () => CplLecturerDataSourceImpl(
      client: locator(),
      authPreferenceHelper: locator(),
    ),
  );
  locator.registerLazySingleton<AttendanceDataSource>(
    () => AttendanceDataSourceImpl(
      client: locator(),
      authPreferenceHelper: locator(),
    ),
  );
  locator.registerLazySingleton<CplStudentDataSource>(
    () => CplStudentDataSourceImpl(
      client: locator(),
      authPreferenceHelper: locator(),
    ),
  );
}
