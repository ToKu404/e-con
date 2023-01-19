import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/features/login/provider/error_field_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;

  const UsernameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final fieldNotifer = context.watch<ErrorFieldChecker>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nama Pengguna',
          style: kTextHeme.subtitle1,
        ),
        AppSize.verticalSpace[1],
        TextField(
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
            errorText: fieldNotifer.isUsernameError
                ? 'Nama pengguna wajib diisi'
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
        ),
      ],
    );
  }
}
