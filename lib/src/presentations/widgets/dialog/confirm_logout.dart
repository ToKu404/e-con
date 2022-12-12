import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<dynamic> showConfirmLogout(BuildContext context) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.question,
    body: Center(
      child: Text(
        'Apakah anda serius ingin keluar?',
      ),
    ),
    title: 'Konfirmasi',
    btnCancelColor: Palette.disable,
    btnCancelText: 'Tidak',
    btnCancelOnPress: () => {},
    btnOkColor: Palette.danger,
    btnOkText: 'Ya',
    btnOkOnPress: () async {
      await context.read<AuthNotifier>()
        ..logOut();
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.login,
        (route) => false,
      );
    },
  ).show();
}
