import 'package:e_con/core/app/settings.dart';
import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/routes/route_handler.dart';
import 'package:e_con/core/utils/observer.dart';
import 'package:e_con/core/dependency_injection/init.dart' as di;
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:e_con/src/presentations/features/login/provider/get_user_notifier.dart';
import 'package:e_con/src/presentations/features/menu/bloc/cubit/attendance_cubit.dart';
import 'package:e_con/src/presentations/features/menu/providers/attendance_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/history/provider/attendance_history_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/scan_qr/provider/qr_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_final_exam_helper_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_final_exam_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/course_student_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecture_courses_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecture_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/meeting_course_notifier.dart';
import 'package:e_con/src/presentations/features/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'src/presentations/blocs/realtime_internet_check/realtime_internet_check_cubit.dart';
import 'src/presentations/features/menu/lecturer/providers/lecturer_seminars_notifier.dart';
import 'src/presentations/features/menu/lecturer/providers/lecturer_today_meeting_notifier.dart';
import 'src/presentations/features/menu/providers/profile_picture_notifier.dart';
import 'src/presentations/blocs/onetime_internet_check/onetime_internet_check_cubit.dart';
import 'src/presentations/features/menu/providers/user_notif_notifier.dart';
import 'src/presentations/features/menu/student/providers/student_activity_notifier.dart';

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
        statusBarColor: Palette.teritory,
      ),
    );

    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<OnetimeInternetCheckCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RealtimeInternetCheckCubit>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<GetUserNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AuthNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AttendanceNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ProfilePictureNotifier>(),
        ),
        // Lecturer
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
        ChangeNotifierProvider(
          create: (_) => di.locator<StudentProfileNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<QrNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AttendanceHistoryNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<LecturerTodayMeetingNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<StudentActivityNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<LecturerSeminarNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<StudentFinalExamNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<StudentFinalExamHelperNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<UserNotifNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AttendanceCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppSettings.title,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          primaryColor: Palette.primary,
          colorScheme: ColorScheme.light(
            primary: Palette.primary,
          ),
          dividerColor: Colors.transparent,
        ),
        home: const SplashPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (settings) => routesHandler(settings),
      ),
    );
  }
}
