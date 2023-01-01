import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_con/core/constants/color_const.dart';
import 'package:flutter/material.dart';

Future<bool> showConfirmation({
  required BuildContext context,
  required String title,
}) async {
  bool? result;
  await AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.question,
    body: Center(
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    title: 'Konfirmasi',
    btnCancelColor: Palette.disable,
    btnCancelText: 'Tidak',
    btnCancelOnPress: () {
      result = false;
    },
    btnOkColor: Palette.danger,
    btnOkText: 'Ya',
    btnOkOnPress: () {
      result = true;
    },
  ).show();

  return result ?? false;
}
