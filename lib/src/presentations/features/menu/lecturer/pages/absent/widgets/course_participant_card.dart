import 'package:e_con/src/data/models/attendance/student_attendance_data.dart';
import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:flutter/material.dart';

class CourseParticipantCard extends StatelessWidget {
  const CourseParticipantCard({
    super.key,
    required this.studentData,
  });

  final StudentAttendanceData studentData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: AppSize.space[3],
      ),
      width: AppSize.getAppWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.space[2],
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(AppSize.space[4]),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  studentData.name ?? '-',
                  style: kTextHeme.subtitle2?.copyWith(
                    color: Palette.black,
                  ),
                ),
                Text(
                  studentData.idNumber ?? '-',
                  style: kTextHeme.subtitle1?.copyWith(
                    color: Palette.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Builder(builder: (context) {
            final attendanceStatusCard =
                ReusableFunctionHelper.getAttendanceStat(
                    attendances: studentData.attendances!);
            return Stack(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    color: attendanceStatusCard.statusColor,
                    strokeWidth: 5,
                    backgroundColor: Palette.field,
                    value: attendanceStatusCard.percent / 100,
                  ),
                ),
                Positioned.fill(
                    child: Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: '${attendanceStatusCard.percent}',
                          style: kTextHeme.subtitle2?.copyWith(
                            color: attendanceStatusCard.statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '%',
                              style: kTextHeme.overline?.copyWith(
                                color: attendanceStatusCard.statusColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
              ],
            );
          })
        ],
      ),
    );
  }
}
