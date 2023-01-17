import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/presentations/features/login/pages/login_page.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/scan_qr/student_absent_page.dart';
import 'package:e_con/src/presentations/features/menu/student/student_main_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/teacher_add_meeting_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/teacher_barcode_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/teacher_course_detail_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/teacher_course_member.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/teacher_edit_meeting_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/teacher_gen_barcode_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/teacher_meet_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/setting/teacher_setting_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/teacher_main_page.dart';
import 'package:e_con/src/presentations/features/splash/wrapper.dart';
import 'package:e_con/src/presentations/features/webview/web_view_page.dart';
import 'package:flutter/material.dart';

Route? routesHandler(RouteSettings settings) {
  switch (settings.name) {
    case AppRoute.login:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case AppRoute.wrapper:
      return MaterialPageRoute(builder: (_) => const Wrapper());
    case AppRoute.mainStudent:
      return MaterialPageRoute(builder: (_) => const StudentMainPage());
    case AppRoute.mainTeacher:
      return MaterialPageRoute(builder: (_) => const TeacherMainPage());
    case AppRoute.absentStudent:
      return MaterialPageRoute(builder: (_) => const StudentAbsentPage());
    case AppRoute.detailCourse:
      return MaterialPageRoute(
        builder: (_) => TeacherCourseDetailPage(
          clazzData: settings.arguments as ClazzData,
        ),
      );
    case AppRoute.detailMeet:
      return MaterialPageRoute(
        builder: (_) => TeacherMeetDetailPage(
          args: settings.arguments as Map,
        ),
      );
    case AppRoute.genBarcode:
      return MaterialPageRoute(
        builder: (_) => TeacherGenBarcodePage(
          args: settings.arguments as Map,
        ),
      );
    case AppRoute.barcodeAbsent:
      return MaterialPageRoute(
        builder: (_) => TeacherBarcodePage(
          args: settings.arguments as Map,
        ),
      );
    case AppRoute.listStudent:
      return MaterialPageRoute(
        builder: (_) => TeacherCourseMember(
          classId: settings.arguments as int,
        ),
      );
    case AppRoute.teacherProfile:
      return MaterialPageRoute(
        builder: (_) => const TeacherSettingPage(),
      );
    case AppRoute.addNewMeeting:
      return MaterialPageRoute(
        builder: (_) => TeacherAddMeetingPage(
          clazzData: settings.arguments as ClazzData,
        ),
      );
    case AppRoute.editMeeting:
      return MaterialPageRoute(
        builder: (_) => TeacherEditMeetingPage(
          args: settings.arguments as Map,
        ),
      );
    case AppRoute.cplWebview:
      return MaterialPageRoute(
        builder: (_) => const WebViewPage(),
      );
  }
  return null;
}
