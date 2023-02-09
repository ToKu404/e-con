import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/user/user_credential.dart';
import 'package:e_con/src/presentations/blocs/onetime_internet_check/onetime_internet_check_cubit.dart';
import 'package:e_con/src/presentations/features/login/pages/login_page.dart';
import 'package:e_con/src/presentations/features/login/provider/get_user_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/student_main_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/lecturer_main_page.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OnetimeInternetCheckCubit>(context)
        .onCheckConnectionOnetime();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnetimeInternetCheckCubit, OnetimeInternetCheckState>(
      builder: (context, state) {
        if (state is OnetimeInternetCheckLost) {
          return EconNoInternet(
            onReload: () {
              Future.microtask(() {
                BlocProvider.of<OnetimeInternetCheckCubit>(context)
                    .onCheckConnectionOnetime();
                Provider.of<GetUserNotifier>(context, listen: false).getUser();
              });
            },
            withScaffold: true,
          );
        }

        // Wrapper to check if user is login or not
        final userNotifier = context.watch<GetUserNotifier>();
        if (userNotifier.state == RequestState.loading ||
            userNotifier.state == RequestState.init) {
          return EconLoading(
            withScaffold: true,
          );
        } else if (userNotifier.state == RequestState.success) {
          final UserCredential? user = userNotifier.user;
          return user == null
              ? LoginPage()
              : user.role!.id == 5
                  ? StudentMainPage()
                  : TeacherMainPage();
        } else {
          return EconLoading(
            withScaffold: true,
          );
        }
      },
    );
  }
}
