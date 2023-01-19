import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/presentations/features/login/pages/login_page.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/history/student_meeting_history_page.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/scan_qr/student_absent_page.dart';
import 'package:e_con/src/presentations/features/menu/student/student_main_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/lecturer_add_meeting_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/lecturer_barcode_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/lecturer_course_detail_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/lecturer_course_member.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/lecturer_edit_meeting_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/lecturer_gen_barcode_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/lecturer_meet_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/setting/lecturer_setting_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/lecturer_main_page.dart';
import 'package:e_con/src/presentations/features/splash/wrapper.dart';
import 'package:e_con/src/presentations/features/webview/web_view_page.dart';
import 'package:flutter/material.dart';

Route? routesHandler(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case AppRoutes.wrapper:
      return MaterialPageRoute(builder: (_) => const Wrapper());
    case AppRoutes.mainStudent:
      return MaterialPageRoute(builder: (_) => const StudentMainPage());
    case AppRoutes.mainTeacher:
      return MaterialPageRoute(builder: (_) => const TeacherMainPage());
    case AppRoutes.absentStudent:
      return MaterialPageRoute(builder: (_) => const StudentAbsentPage());
    case AppRoutes.detailCourse:
      return MaterialPageRoute(
        builder: (_) => LecturerCourseDetailPage(
          clazzData: settings.arguments as ClazzData,
        ),
      );
    case AppRoutes.detailMeet:
      return MaterialPageRoute(
        builder: (_) => LecturerMeetDetailPage(
          args: settings.arguments as Map,
        ),
      );
    case AppRoutes.genBarcode:
      return MaterialPageRoute(
        builder: (_) => LecturerGenBarcodePage(
          args: settings.arguments as Map,
        ),
      );
    case AppRoutes.barcodeAbsent:
      return MaterialPageRoute(
        builder: (_) => LecturerBarcodePage(
          args: settings.arguments as Map,
        ),
      );
    case AppRoutes.listStudent:
      return MaterialPageRoute(
        builder: (_) => LecturerCourseMember(
          classId: settings.arguments as int,
        ),
      );
    case AppRoutes.listStudentClasses:
      return MaterialPageRoute(
        builder: (_) => StudentMeetingHistoryPage(
          clazzData: settings.arguments as ClazzData,
        ),
      );

    case AppRoutes.teacherProfile:
      return MaterialPageRoute(
        builder: (_) => const LecturerSettingPage(),
      );
    case AppRoutes.addNewMeeting:
      return MaterialPageRoute(
        builder: (_) => LecturerAddMeetingPage(
          clazzData: settings.arguments as ClazzData,
        ),
      );
    case AppRoutes.editMeeting:
      return MaterialPageRoute(
        builder: (_) => LecturerEditMeetingPage(
          args: settings.arguments as Map,
        ),
      );
    case AppRoutes.cplWebview:
      return MaterialPageRoute(
        builder: (_) => const WebViewPage(),
      );
  }
  return null;
}
