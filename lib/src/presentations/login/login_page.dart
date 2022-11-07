import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/widgets/custom_button.dart';
import 'package:e_con/widgets/header_logo.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
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
                        CustomButton(
                          text: 'Lanjutkan',
                          onTap: () {},
                        ),
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  const UsernameField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {},
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
        // errorText: !state.isEmailValid
        //     ? 'Please ensure the email entered is valid'
        //     : null,
        // labelText: 'Email',
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordField({super.key, required this.controller});

  @override
  State<PasswordField> createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  ValueNotifier<bool> isHide = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isHide,
        builder: (context, data, _) {
          return TextField(
            controller: widget.controller,
            cursorColor: Palette.primary,
            obscureText: data,
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
            ),
          );
        });
  }
}
