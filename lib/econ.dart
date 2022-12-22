import 'package:e_con/core/app/settings.dart';
import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/routes/route_handler.dart';
import 'package:e_con/core/utils/observer.dart';
import 'package:e_con/injection.dart' as di;
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:e_con/src/presentations/features/login/provider/get_user_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/lecture_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/meeting_course_notifier.dart';
import 'package:e_con/src/presentations/features/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'src/presentations/features/menu/teacher/providers/course_student_notifier.dart';
import 'src/presentations/features/menu/teacher/providers/lecture_courses_notifier.dart';

class EconApp extends StatelessWidget {
  const EconApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Palette.primary,
        statusBarColor: Palette.primaryVariant,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<GetUserNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AuthNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<StudentProfileNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<LectureProfileNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<LectureCourseNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MeetingCourseNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<CourseStudentNotifier>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppSettings.title,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: const SplashPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (settings) => routesHandler(settings),
      ),
    );
  }
}
