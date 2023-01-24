import 'package:e_con/src/domain/usecases/activity_usecases/get_all_meeting_by_date.dart';
import 'package:e_con/src/domain/usecases/attendance_usecases/get_list_attendance.dart';
import 'package:e_con/src/domain/usecases/attendance_usecases/get_list_student_attendance.dart';
import 'package:e_con/src/domain/usecases/attendance_usecases/set_attendance.dart';
import 'package:e_con/src/domain/usecases/attendance_usecases/set_attendance_by_student.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/create_new_meeting.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_attendance_statistic.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_list_course.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_list_meeting.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_meeting_data.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_validation_code.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/set_attendance_validation_code.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/update_meeting.dart';
import 'package:e_con/src/domain/usecases/cpl_student_usecases/get_list_student_attendance_history.dart';
import 'package:e_con/src/domain/usecases/cpl_student_usecases/get_list_student_classes.dart';
import 'package:e_con/src/domain/usecases/final_exam_lecturer_usecases/get_detail_seminar.dart';
import 'package:e_con/src/domain/usecases/final_exam_lecturer_usecases/get_invited_seminars.dart';
import 'package:e_con/src/domain/usecases/final_exam_student_usecases/get_detail_seminar_by_student.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_lecture_data.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_profile_picture.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_student_data.dart';
import 'package:e_con/src/domain/usecases/user_usecases/get_user.dart';
import 'package:e_con/src/domain/usecases/user_usecases/log_out.dart';
import 'package:e_con/src/domain/usecases/user_usecases/sign_in.dart';
import 'package:get_it/get_it.dart';

import '../../src/domain/usecases/cpl_lecturer_usecases/delete_meeting.dart';

void injectUsecases(GetIt locator) {
  // Auth Usecase
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

  // Profile Usecases
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
    () => GetProfilePicture(
      profileRepository: locator(),
    ),
  );

  // CPL Lecturer Usecases
  locator.registerLazySingleton(
    () => GetListCourse(
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
    () => GetAttendanceStatistic(
      cplLecturerRepository: locator(),
    ),
  );

  // Attendance Usecases
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
    () => GetListStudentAttendance(
      attendanceRepository: locator(),
    ),
  );

  // Cpl Student Usecases
  locator.registerLazySingleton(
    () => GetListStudentAttendanceHistory(
      cplStudentRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetListStudentClasses(
      cplStudentRepository: locator(),
    ),
  );

  // Activity Usecase
  locator.registerLazySingleton(
    () => GetAllMeetingByDate(
      activityRepository: locator(),
    ),
  );

  // Final Exam Lecturer
  locator.registerLazySingleton(
    () => GetInvitedSeminars(
      finalExamLecturerRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetDetailSeminar(
      finalExamLecturerRepository: locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetDetailSeminarByStudent(
      finalExamStudentRepository: locator(),
    ),
  );
}
