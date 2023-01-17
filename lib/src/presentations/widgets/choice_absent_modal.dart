import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/data/models/attendance/helpers/attendance_value.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChoiceAbsentModal extends StatelessWidget {
  final AttendanceValue attendanceValue;
  final StudentData studentData;
  const ChoiceAbsentModal(
      {super.key, required this.attendanceValue, required this.studentData});

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
    final ValueNotifier<AttendanceValue> selectedAttedanceValue =
        ValueNotifier(attendanceValue);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.space[2],
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close_rounded,
                ),
              ),
              Expanded(
                child: Text(
                  'Ubah Status Absensi',
                  textAlign: TextAlign.center,
                  style: kTextHeme.subtitle1?.copyWith(
                    color: Palette.onPrimary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  
                },
                icon: const Icon(
                  Icons.check_rounded,
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
              valueListenable: selectedAttedanceValue,
              builder: (context, val, _) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: AppSize.space[5],
                    right: AppSize.space[5],
                    bottom: AppSize.space[3],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Absensi',
                        style: kTextHeme.subtitle2,
                      ),
                      Text(
                        studentData.name!,
                        style: kTextHeme.headline5?.copyWith(
                          color: Palette.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSize.verticalSpace[3],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: AttendanceValueHelper.getAllAttendance()
                            .map((aValue) {
                          final isSelected = aValue == val;

                          return InkWell(
                            onTap: () => selectedAttedanceValue.value = aValue,
                            child: Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      AppSize.space[3],
                                    ),
                                    color: isSelected
                                        ? aValue.id == 2
                                            ? Palette.danger
                                            : aValue.color
                                        : Palette.background,
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: SvgPicture.asset(
                                        aValue.iconPath,
                                        color: isSelected
                                            ? Palette.white
                                            : Palette.disable,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  aValue.status,
                                  style: kTextHeme.subtitle2?.copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? aValue.id == 2
                                            ? Palette.danger
                                            : aValue.color
                                        : Palette.disable,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
