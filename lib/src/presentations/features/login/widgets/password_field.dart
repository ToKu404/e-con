import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/features/login/provider/error_field_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kata Sandi',
          style: kTextHeme.subtitle1,
        ),
        AppSize.verticalSpace[1],
        ValueListenableBuilder<bool>(
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
                filled: true,
                fillColor: Palette.field,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Palette.white),
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
                    color: Palette.black,
                  ),
                ),
                errorText: fieldNotifer.isPasswordError
                    ? 'Kata sandi wajib diisi'
                    : null,
                errorStyle: TextStyle(height: 1),
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
        ),
      ],
    );
  }
}
