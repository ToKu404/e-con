import 'dart:async';

import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:flutter/material.dart';

class InputDateTimeField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final DateTime? initialDate;
  final FutureOr<void> Function(DateTime date)? action;

  const InputDateTimeField(
      {super.key,
      required this.action,
      required this.controller,
      required this.hintText,
      this.initialDate});

  @override
  State<InputDateTimeField> createState() => _InputDateTimeFieldState();
}

class _InputDateTimeFieldState extends State<InputDateTimeField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: () async {
        final dateSelected = await showDatePicker(
          context: context,
          initialDate: widget.controller.text.isEmpty
              ? DateTime.now()
              : ReusableFuntionHelper.stringToDateTime(widget.controller.text),
          firstDate: widget.initialDate != null
              ? (widget.initialDate!.isBefore(DateTime.now())
                  ? widget.initialDate!
                  : DateTime.now())
              : DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(
              days: 30,
            ),
          ),
        );

        if (dateSelected == null) return;

        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(DateTime.now()),
        );

        if (time == null) return;

        setState(() {
          final dateTime = DateTime(dateSelected.year, dateSelected.month,
              dateSelected.day, time.hour, time.minute);
          widget.controller.text = ReusableFuntionHelper.datetimeToString(
              dateTime,
              isShowTime: true);
          widget.action!.call(dateTime);
        });
      },
      keyboardType: TextInputType.text,
      style: kTextHeme.subtitle1?.copyWith(
        color: Palette.onPrimary,
      ),
      cursorColor: Palette.primary,
      decoration: InputDecoration(
        hintText: widget.hintText,
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
