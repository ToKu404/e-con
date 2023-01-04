import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  const InputField({super.key, required this.controller, required this.text});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: (value) {},
      keyboardType: TextInputType.text,
      style: kTextHeme.subtitle1?.copyWith(
        color: Palette.onPrimary,
      ),
      cursorColor: Palette.primary,
      decoration: InputDecoration(
        hintText: widget.text,
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
      ),
    );
  }
}
