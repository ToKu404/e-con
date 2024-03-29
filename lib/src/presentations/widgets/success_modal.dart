import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/scan_qr/provider/qr_notifier.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuccessAttendanceModal extends StatelessWidget {
  const SuccessAttendanceModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSize.space[2],
        ),
      ),
      elevation: 1,
      backgroundColor: Colors.transparent,
      child: contentSuccess(context),
    );
  }

  Widget contentSuccess(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        AppSize.space[4],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.space[2],
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Palette.primary,
            ),
            child: const Center(
              child: Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 65,
              ),
            ),
          ),
          AppSize.verticalSpace[4],
          Text(
            'Berhasil',
            style: kTextHeme.headline5?.copyWith(
              color: Palette.primary,
            ),
          ),
          Text(
            'Absen Berhasil',
            style: kTextHeme.subtitle1?.copyWith(
              color: Palette.primary,
            ),
          ),
          AppSize.verticalSpace[0],
          Text(
            ReusableFunctionHelper.datetimeToString(DateTime.now(),
                format: 'HH:mm dd-MM-yyyy'),
            style: kTextHeme.subtitle2?.copyWith(
              color: Palette.disable,
            ),
          ),
          AppSize.verticalSpace[3],
          CustomButton(
            text: 'Kembali',
            onTap: () {
              context.read<QrNotifier>()..resetQrCode();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            height: 45,
          )
        ],
      ),
    );
  }
}
