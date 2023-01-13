// ignore_for_file: depend_on_referenced_packages

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/src/data/datasources/auth_datasource.dart';
import 'package:e_con/src/data/datasources/cpl_lecturer_datasource.dart';
import 'package:e_con/src/data/datasources/profile_datasource.dart';
import 'package:e_con/src/data/repositories/auth_repository_impl.dart';
import 'package:e_con/src/data/repositories/cpl_lecturer_repository_impl.dart';
import 'package:e_con/src/data/repositories/profile_repository_impl.dart';
import 'package:e_con/src/domain/repositories/auth_repository.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';
import 'package:e_con/src/domain/repositories/profile_repository.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/create_new_meeting.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/delete_meeting.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_list_course.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_list_meeting.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_list_student.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_validation_code.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/update_meeting.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_lecture_data.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_student_data.dart';
import 'package:e_con/src/domain/usecases/user_usecases/get_user.dart';
import 'package:e_con/src/domain/usecases/user_usecases/log_out.dart';
import 'package:e_con/src/domain/usecases/user_usecases/sign_in.dart';
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:e_con/src/presentations/features/login/provider/get_user_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/course_student_notifier.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/lecture_courses_notifier.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/lecture_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/meeting_course_notifier.dart';
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
  locator.registerLazySingleton<CplLecturerRepository>(
    () => CplLecturerRepositoryImpl(
      cplLecturerDataSource: locator(),
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
  locator.registerLazySingleton<CplLecturerDataSource>(
    () => CplLecturerDataSourceImpl(
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
  locator.registerLazySingleton(
    () => GetListCourse(
      cplLecturerRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetListStudent(
      cplLecturerRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetListMeeting(
      cplLecturerRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => CreateNewMeeting(
      cplLecturerRepository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => DeleteMeeting(
      cplLecturerRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => UpdateMeeting(
      cplLecturerRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetValidationCode(
      cplLecturerRepository: locator(),
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
  locator.registerFactory(
    () => LectureCourseNotifier(
      getListCourseUsecase: locator(),
    ),
  );
  locator.registerFactory(
    () => CourseStudentNotifier(
      getListStudentUsecase: locator(),
    ),
  );
  locator.registerFactory(
    () => MeetingCourseNotifier(
        getValidationCodeUsecase: locator(),
        getListMeetingUsecase: locator(),
        createNewMeetingUsecase: locator(),
        deleteMeetingUsecase: locator(),
        updateMeetingUsecase: locator()),
  );

  // client w/ SSL pinning certified
  locator.registerLazySingleton(() => http.Client());

  // external
  locator.registerLazySingleton<AuthPreferenceHelper>(
      () => AuthPreferenceHelper());
}
