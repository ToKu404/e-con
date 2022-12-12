import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/user/helper/user_role_type.dart';
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:e_con/src/presentations/features/login/provider/error_field_checker.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:e_con/src/presentations/widgets/econ_loading.dart';
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

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<AuthNotifier>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (authNotifier.loginState == RequestState.error) {
        Navigator.pop(context);
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          autoHide: Duration(seconds: 2, milliseconds: 500),
          body: Center(
            child: Text(
              authNotifier.error,
            ),
          ),
          title: 'Gagal Login',
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
      } else if (authNotifier.loginState == RequestState.success) {
        Navigator.pop(context);
        if (authNotifier.user != null) {
          if (authNotifier.user!.role == UserRole.student) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoute.mainStudent,
              (route) => false,
            );
          } else if (authNotifier.user!.role == UserRole.teacher) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoute.mainTeacher,
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
            backgroundColor: Palette.background,
            body: SafeArea(
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
                                  height: 8,
                                ),
                                PasswordField(
                                  controller: passwordController,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Builder(builder: (context) {
                                  return CustomButton(
                                    text: 'Lanjutkan',
                                    onTap: () =>
                                        _onPressedSignInButton(context),
                                  );
                                }),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 24,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Lupa kata sandi?',
                                    style: kTextHeme.subtitle1?.copyWith(
                                      color: Palette.disable,
                                    ),
                                  ),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: 'Silahkan hubungi',
                                      style: kTextHeme.subtitle1?.copyWith(
                                        color: Palette.disable,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' Administrator',
                                          style: kTextHeme.subtitle1?.copyWith(
                                            color: Palette.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                    ),
                  )
                ],
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

class UsernameField extends StatelessWidget {
  final TextEditingController controller;

  const UsernameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final fieldNotifer = context.watch<ErrorFieldChecker>();
    return TextField(
      controller: controller,
      onTap: () {
        fieldNotifer.usernameActive();
      },
      keyboardType: TextInputType.text,
      style: kTextHeme.subtitle1?.copyWith(
        color: Palette.onPrimary,
      ),
      cursorColor: Palette.primary,
      decoration: InputDecoration(
        hintText: 'Nama Pengguna',
        hintStyle: kTextHeme.subtitle1,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Palette.background),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Palette.primary),
          borderRadius: BorderRadius.circular(12.0),
        ),
        errorText:
            fieldNotifer.isUsernameError ? 'Username tidak boleh kosong' : null,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(12.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordField({
    super.key,
    required this.controller,
  });

  @override
  State<PasswordField> createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  ValueNotifier<bool> isHide = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    final fieldNotifer = context.watch<ErrorFieldChecker>();

    return ValueListenableBuilder<bool>(
      valueListenable: isHide,
      builder: (context, data, _) {
        return TextField(
          controller: widget.controller,
          cursorColor: Palette.primary,
          obscureText: data,
          onTap: () {
            fieldNotifer.passwordActive();
          },
          style: kTextHeme.subtitle1?.copyWith(
            color: Palette.onPrimary,
          ),
          decoration: InputDecoration(
            hintText: 'Kata Sandi',
            hintStyle: kTextHeme.subtitle1,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Palette.background),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Palette.primary),
              borderRadius: BorderRadius.circular(12.0),
            ),
            suffixIcon: IconButton(
              onPressed: () async {
                isHide.value = !data;
              },
              icon: Icon(
                isHide.value ? Icons.visibility_off : Icons.visibility,
                color: Palette.background,
              ),
            ),
            errorText: fieldNotifer.isPasswordError
                ? 'Password tidak boleh kosong'
                : null,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(12.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        );
      },
    );
  }
}
