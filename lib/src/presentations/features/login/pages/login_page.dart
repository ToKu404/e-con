import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/user/helper/user_role_type.dart';
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:e_con/src/presentations/features/login/provider/error_field_checker.dart';
import 'package:e_con/src/presentations/features/login/widgets/password_field.dart';
import 'package:e_con/src/presentations/features/login/widgets/username_field.dart';
import 'package:e_con/src/presentations/reusable_pages/check_internet_single.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:e_con/src/presentations/widgets/header_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  bool isLoadingEnd = false;

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<AuthNotifier>();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (authNotifier.loginState == RequestState.error) {
        if (isLoadingEnd) Navigator.pop(context);
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          autoHide: Duration(seconds: 2, milliseconds: 500),
          body: Center(
            child: Text(
              'Data Pengguna Tidak Ditemukan',
            ),
          ),
          title: 'Data Pengguna Tidak Ditemukan',
          btnOkColor: Palette.primary,
          btnOkText: 'Kembali',
          btnOkOnPress: () {},
        ).show();
      } else if (authNotifier.loginState == RequestState.loading) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return EconLoading();
          },
        );
        isLoadingEnd = true;
      } else if (authNotifier.loginState == RequestState.success) {
        if (isLoadingEnd) Navigator.pop(context);
        if (authNotifier.user != null) {
          if (authNotifier.user!.role == UserRole.student) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.mainStudent,
              (route) => false,
            );
          } else if (authNotifier.user!.role == UserRole.teacher) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.mainTeacher,
              (route) => false,
            );
          }
        }
      }
    });

    return ChangeNotifierProvider(
        create: (_) => ErrorFieldChecker(),
        builder: (context, _) {
          return Scaffold(
            backgroundColor: Palette.white,
            body: SafeArea(
              child: CheckInternetSingle(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Builder(builder: (context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: HeaderLogo(
                                  bgColor: Palette.primaryVariant.withOpacity(
                                    .07,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Selamat',
                                      style: kTextHeme.headline2?.copyWith(
                                        color: Palette.onPrimary,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' Datang',
                                          style: kTextHeme.headline2?.copyWith(
                                            color: Palette.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  UsernameField(
                                    controller: usernameController,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  PasswordField(
                                    controller: passwordController,
                                  ),
                                  const SizedBox(
                                    height: 28,
                                  ),
                                  Builder(builder: (context) {
                                    return CustomButton(
                                      text: 'Masuk',
                                      onTap: () =>
                                          _onPressedSignInButton(context),
                                    );
                                  }),
                                ],
                              ),
                              SizedBox.shrink()
                            ],
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _onPressedSignInButton(BuildContext context) {
    FocusScope.of(context).unfocus();

    final fieldProvider = context.read<ErrorFieldChecker>();
    fieldProvider.startChecker(
        usernameController.text, passwordController.text);

    if (!fieldProvider.isUsernameError && !fieldProvider.isPasswordError) {
      final authNotifier = context.read<AuthNotifier>();

      authNotifier.signIn(usernameController.text, passwordController.text);
    }
  }
}
