import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/user_credential.dart';
import 'package:e_con/src/data/models/user_role.dart';
import 'package:e_con/src/presentations/features/login/pages/login_page.dart';
import 'package:e_con/src/presentations/features/login/provider/get_user_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/student_main_page.dart';
import 'package:e_con/src/presentations/features/menu/teacher/teacher_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrapper to check if user is login or not
    final userNotifier = context.watch<GetUserNotifier>();
    if (userNotifier.state == RequestState.loading) {
      return Scaffold(
          body: Center(
        child: SpinKitFadingCircle(
          itemBuilder: (_, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: index.isEven ? Palette.primary : Palette.secondary,
              ),
            );
          },
          size: 50.0,
        ),
      ));
    } else if (userNotifier.state == RequestState.success) {
      final UserCredential? user = userNotifier.user;
      return user == null
          ? LoginPage()
          : user.role == UserRole.student
              ? StudentMainPage()
              : TeacherMainPage();
    } else {
      return Center(
        child: Text(userNotifier.error),
      );
    }
  }
}
