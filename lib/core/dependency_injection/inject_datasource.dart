import 'package:e_con/src/data/datasources/activity_datasource.dart';
import 'package:e_con/src/data/datasources/attendance_datasource.dart';
import 'package:e_con/src/data/datasources/auth_datasource.dart';
import 'package:e_con/src/data/datasources/cpl_lecturer_datasource.dart';
import 'package:e_con/src/data/datasources/cpl_student_datasource.dart';
import 'package:e_con/src/data/datasources/final_exam_lecturer_datasource.dart';
import 'package:e_con/src/data/datasources/final_exam_student_datasource.dart';
import 'package:e_con/src/data/datasources/profile_datasource.dart';
import 'package:e_con/src/data/repositories/final_exam_lecturer_repository_impl.dart';
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
  locator.registerLazySingleton<ActivityDataSource>(
    () => ActivityDataSourceImpl(
      client: locator(),
      authPreferenceHelper: locator(),
    ),
  );
  locator.registerLazySingleton<FinalExamLecturerDataSource>(
    () => FinalExamLecturerDataSourceImpl(
      client: locator(),
      authPreferenceHelper: locator(),
    ),
  );
  locator.registerLazySingleton<FinalExamStudentDataSource>(
    () => FinalExamStudentDataSourceImpl(
      client: locator(),
      authPreferenceHelper: locator(),
    ),
  );
}
