import 'package:e_con/src/data/repositories/activity_repository_impl.dart';
import 'package:e_con/src/data/repositories/attendance_repository_impl.dart';
import 'package:e_con/src/data/repositories/auth_repository_impl.dart';
import 'package:e_con/src/data/repositories/cpl_lecturer_repository_impl.dart';
import 'package:e_con/src/data/repositories/cpl_student_repository_impl.dart';
import 'package:e_con/src/data/repositories/final_exam_lecturer_repository_impl.dart';
import 'package:e_con/src/data/repositories/profile_repository_impl.dart';
import 'package:e_con/src/domain/repositories/activity_repository.dart';
import 'package:e_con/src/domain/repositories/attendance_repository.dart';
import 'package:e_con/src/domain/repositories/auth_repository.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';
import 'package:e_con/src/domain/repositories/cpl_student_repository.dart';
import 'package:e_con/src/domain/repositories/final_exam_lecturer_repository.dart';
import 'package:e_con/src/domain/repositories/profile_repository.dart';
import 'package:get_it/get_it.dart';

void injectRepository(GetIt locator) {
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
  locator.registerLazySingleton<CplLecturerRepository>(
    () => CplLecturerRepositoryImpl(
      cplLecturerDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(
      attendanceDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<CplStudentRepository>(
    () => CplStudentRepositoryImpl(
      cplStudentLecturer: locator(),
    ),
  );
  locator.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(
      activityDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<FinalExamLecturerRepository>(
    () => FinalExamLecturerRepositoryImpl(
      finalExamLecturerDataSource: locator(),
    ),
  );
}
