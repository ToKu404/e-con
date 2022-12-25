import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/user/user_credential.dart';
import 'package:e_con/src/data/models/user/helper/user_role_type.dart';
import 'package:e_con/src/presentations/features/login/pages/login_page.dart';
import 'package:e_con/src/presentations/features/login/provider/get_user_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/student_main_page.dart';
import 'package:e_con/src/presentations/features/menu/teacher/teacher_main_page.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrapper to check if user is login or not
    final userNotifier = context.watch<GetUserNotifier>();
    if (userNotifier.state == RequestState.loading) {
      return EconLoading(
        withScaffold: true,
      );
    } else if (userNotifier.state == RequestState.success) {
      final UserCredential? user = userNotifier.user;
      return user == null
          ? LoginPage()
          : user.role == UserRole.student
              ? StudentMainPage()
              : TeacherMainPage();
    } else {
      return EconError(
        errorMessage: userNotifier.error,
        withScaffold: true,
      );
    }
  }
}
