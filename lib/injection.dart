// ignore_for_file: depend_on_referenced_packages

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/src/data/datasources/attendance_datasource.dart';
import 'package:e_con/src/data/datasources/auth_datasource.dart';
import 'package:e_con/src/data/datasources/cpl_lecturer_datasource.dart';
import 'package:e_con/src/data/datasources/profile_datasource.dart';
import 'package:e_con/src/data/repositories/attendance_repository_impl.dart';
import 'package:e_con/src/data/repositories/auth_repository_impl.dart';
import 'package:e_con/src/data/repositories/cpl_lecturer_repository_impl.dart';
import 'package:e_con/src/data/repositories/profile_repository_impl.dart';
import 'package:e_con/src/domain/repositories/attendance_repository.dart';
import 'package:e_con/src/domain/repositories/auth_repository.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';
import 'package:e_con/src/domain/repositories/profile_repository.dart';
import 'package:e_con/src/domain/usecases/attendance_usecases/get_list_attendance.dart';
import 'package:e_con/src/domain/usecases/attendance_usecases/get_list_student_attendance.dart';
import 'package:e_con/src/domain/usecases/attendance_usecases/set_attendance.dart';
import 'package:e_con/src/domain/usecases/attendance_usecases/set_attendance_by_student.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/create_new_meeting.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/delete_meeting.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_attendance_statistic.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_list_course.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_list_meeting.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_list_student.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_meeting_data.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_validation_code.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/set_attendance_validation_code.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/update_meeting.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_lecture_data.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_profile_picture.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_student_data.dart';
import 'package:e_con/src/domain/usecases/user_usecases/get_user.dart';
import 'package:e_con/src/domain/usecases/user_usecases/log_out.dart';
import 'package:e_con/src/domain/usecases/user_usecases/sign_in.dart';
import 'package:e_con/src/presentations/blocs/realtime_internet_check/realtime_internet_check_cubit.dart';
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:e_con/src/presentations/features/login/provider/get_user_notifier.dart';
import 'package:e_con/src/presentations/features/menu/providers/attendance_notifier.dart';
import 'package:e_con/src/presentations/features/menu/providers/profile_picture_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/scan_qr/provider/qr_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/course_student_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecture_courses_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecture_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/meeting_course_notifier.dart';
import 'package:e_con/src/presentations/blocs/onetime_internet_check/onetime_internet_check_cubit.dart';
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
  locator.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(
      attendanceDataSource: locator(),
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
  locator.registerLazySingleton<AttendanceDataSource>(
    () => AttendanceDataSourceImpl(
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
  locator.registerLazySingleton(
    () => SetAttendanceExpiredDate(
      cplLecturerRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetMeetingData(
      cplLecturerRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SetAttendance(
      attendanceRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SetAttendanceByStudent(
      attendanceRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetListAttendance(
      attendanceRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetAttendanceStatistic(
      cplLecturerRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetListStudentAttendance(
      attendanceRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetProfilePicture(
      profileRepository: locator(),
    ),
  );

  // Provider
  locator.registerFactory(
    () => OnetimeInternetCheckCubit(),
  );
  locator.registerFactory(
    () => RealtimeInternetCheckCubit(),
  );
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
      updateMeetingUsecase: locator(),
      setAttendanceExpiredDateUsecase: locator(),
      getMeetingDataUsecase: locator(),
      getAttendanceStatisticUsecase: locator(),
    ),
  );
  locator.registerFactory(
    () => AttendanceNotifier(
      setAttendanceUsecase: locator(),
      getListAttendanceUsecase: locator(),
      setAttendanceByStudentUsecase: locator(),
    ),
  );
  locator.registerFactory(
    () => ProfilePictureNotifier(
      getProfilePictureUsecase: locator(),
    ),
  );

  // Student Provider
  locator.registerFactory(
    () => QrNotifier(
      getMeetingDataUsecase: locator(),
    ),
  );

  // client w/ SSL pinning certified
  locator.registerLazySingleton(() => http.Client());

  // external
  locator.registerLazySingleton<AuthPreferenceHelper>(
      () => AuthPreferenceHelper());
}
