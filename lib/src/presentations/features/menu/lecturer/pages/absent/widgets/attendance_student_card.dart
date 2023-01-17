import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/data/models/attendance/helpers/attendance_value.dart';
import 'package:e_con/src/presentations/widgets/choice_absent_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AttedanceStudentCard extends StatelessWidget {
  final AttendanceData attendanceData;
  const AttedanceStudentCard({
    super.key,
    required this.attendanceData,
  });

  @override
  Widget build(BuildContext context) {
    final attendanceValue =
        AttendanceValueHelper.getAttendanceValue(attendanceData.attendanceType!.id!);
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return ChoiceAbsentModal(
              attendanceValue: attendanceValue,
              studentData: attendanceData.studentData!,
            );
          },
        );
      },
      child: Container(
        width: AppSize.getAppWidth(context),
        padding: EdgeInsets.all(AppSize.space[3]),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppSize.space[3],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attendanceData.studentData?.name ?? '-',
                    style: kTextHeme.subtitle2?.copyWith(
                      color: Palette.black,
                    ),
                  ),
                  Text(
                    attendanceData.studentData?.nim ?? '-',
                    style: kTextHeme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Palette.primary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.space[2],
              ),
              child: Container(
                padding: EdgeInsets.all(
                  AppSize.space[0],
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: attendanceValue.color,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    attendanceValue.iconPath,
                    color: attendanceValue.color,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
