import 'package:e_con/src/presentations/blocs/realtime_internet_check/realtime_internet_check_cubit.dart';
import 'package:e_con/src/presentations/features/menu/bloc/cubit/attendance_cubit.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecturer_seminars_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecturer_today_meeting_notifier.dart';
import 'package:e_con/src/presentations/features/menu/providers/user_notif_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_activity_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_final_exam_helper_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_final_exam_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:e_con/src/presentations/features/login/provider/get_user_notifier.dart';
import 'package:e_con/src/presentations/features/menu/providers/attendance_notifier.dart';
import 'package:e_con/src/presentations/features/menu/providers/profile_picture_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/history/provider/attendance_history_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/scan_qr/provider/qr_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/course_student_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecture_courses_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecture_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/meeting_course_notifier.dart';
import 'package:e_con/src/presentations/blocs/onetime_internet_check/onetime_internet_check_cubit.dart';

void injectProvider(GetIt locator) {
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
      getCredentialUsecase: locator(),
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

  locator.registerFactory(
    () => QrNotifier(
      getMeetingDataUsecase: locator(),
    ),
  );

  locator.registerFactory(
    () => AttendanceHistoryNotifier(
      getListStudentAttendanceUsecase: locator(),
      getListStudentClasses: locator(),
    ),
  );
  locator.registerFactory(
    () => LecturerTodayMeetingNotifier(
      getAllMeetingByDate: locator(),
    ),
  );
  locator.registerFactory(
    () => StudentActivityNotifier(
      getAllMeetingByDate: locator(),
    ),
  );
  locator.registerFactory(
    () => LecturerSeminarNotifier(
      getInvitedSeminarsUsecases: locator(),
      getDetailSeminarUsecase: locator(),
    ),
  );
  locator.registerFactory(
    () => StudentFinalExamNotifier(
      // getDetailSeminarByStudentUsecase: locator(),
      getProposedThesisUsecase: locator(),
      getSeminarsUsecase: locator(),
      getThesisTrialExamUsecase: locator(),
    ),
  );
  locator.registerFactory(
    () => StudentFinalExamHelperNotifier(),
  );
  locator.registerFactory(
    () => UserNotifNotifier(
      getNotifications: locator(),
    ),
  );
  locator.registerFactory(
    () => AttendanceCubit(
      getListAttendanceUsecase: locator(),
    ),
  );
}
