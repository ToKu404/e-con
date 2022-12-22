import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/src/presentations/features/login/pages/login_page.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/scan_qr/student_absent_page.dart';
import 'package:e_con/src/presentations/features/menu/student/student_main_page.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/absent/teacher_barcode_page.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/absent/teacher_course_detail_page.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/absent/teacher_course_member.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/absent/teacher_gen_barcode_page.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/absent/teacher_meet_page.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/setting/teacher_setting_page.dart';
import 'package:e_con/src/presentations/features/menu/teacher/teacher_main_page.dart';
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
        builder: (_) => const TeacherCourseDetailPage(),
      );
    case AppRoute.detailMeet:
      return MaterialPageRoute(
        builder: (_) => const TeacherMeetDetailPage(),
      );
    case AppRoute.genBarcode:
      return MaterialPageRoute(
        builder: (_) => const TeacherGenBarcodePage(),
      );
    case AppRoute.barcodeAbsent:
      return MaterialPageRoute(
        builder: (_) => const TeacherBarcodePage(),
      );
    case AppRoute.listStudent:
      return MaterialPageRoute(
        builder: (_) => const TeacherCourseMember(),
      );
    case AppRoute.teacherProfile:
      return MaterialPageRoute(
        builder: (_) => const TeacherSettingPage(),
      );
    case AppRoute.cplWebview:
      return MaterialPageRoute(
        builder: (_) => const WebViewPage(),
      );
  }
  return null;
}
