import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/data/models/attendance/helpers/attendance_value.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/meeting_course_notifier.dart';
import 'package:e_con/src/presentations/features/menu/providers/attendance_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ChoiceAbsentModal extends StatelessWidget {
  final AttendanceValue attendanceValue;
  final StudentData studentData;
  final int meetingId;
  final int attendenceId;
  const ChoiceAbsentModal({
    super.key,
    required this.attendanceValue,
    required this.studentData,
    required this.meetingId,
    required this.attendenceId,
  });

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
                onPressed: () async {
                  final provider = context.read<AttendanceNotifier>();
                  final meetingProvider = context.read<MeetingCourseNotifier>();

                  if (selectedAttedanceValue.value != attendanceValue) {
                    await provider.setAttendance(
                      attendanceTypeId: selectedAttedanceValue.value.id,
                      studentId: studentData.id!,
                      meetingId: meetingId,
                      attendanceId: attendenceId,
                    );

                    await provider.fetchListAttendance(meetingId: meetingId);
                    await meetingProvider
                        .getListAttendanceStatistic(meetingId: meetingId)
                        .then((value) {
                      Navigator.pop(context);
                    });
                  } else {
                    Navigator.pop(context);
                  }
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
                        style:
                            kTextHeme.subtitle2?.copyWith(color: Palette.black),
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
              }),
        ],
      ),
    );
  }
}
