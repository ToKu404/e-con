import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/data/models/attendance/helpers/attendance_value.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/statistic_data.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/meeting_course_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherMeetCard extends StatefulWidget {
  final MeetingData meetingData;
  final ClazzData classData;
  const TeacherMeetCard({
    super.key,
    required this.meetingData,
    required this.classData,
  });

  @override
  State<TeacherMeetCard> createState() => _TeacherMeetCardState();
}

class _TeacherMeetCardState extends State<TeacherMeetCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.pushNamed(context, AppRoutes.detailMeet, arguments: {
          'meetingId': widget.meetingData.id,
          'classData': widget.classData,
          'meetingNumber': widget.meetingData.meetingNumber,
        }).then((value) async {
          context
              .read<MeetingCourseNotifier>()
              .getListMeeting(classId: widget.classData.id!);
        });
      },
      child: Container(
        height: 120,
        margin: EdgeInsets.only(
          bottom: AppSize.space[2],
        ),
        padding: EdgeInsets.all(
          AppSize.space[3],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.space[2],
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ReusableFunctionHelper.datetimeToString(
                            widget.meetingData.date!),
                        style: kTextHeme.overline?.copyWith(
                          color: Palette.disable,
                        ),
                      ),
                      Text(
                        'Pertemuan ${widget.meetingData.meetingNumber}',
                        style: kTextHeme.subtitle1?.copyWith(
                          color: Palette.primaryVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.meetingData.topics ?? '-',
                        style: kTextHeme.overline?.copyWith(
                          color: Palette.disable,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(builder: (context) {
                  final statusMeeting =
                      ReusableFunctionHelper.checkStatusMeeting(
                          widget.meetingData.date!);
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSize.space[5],
                      ),
                      color: statusMeeting.color,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.space[3],
                      vertical: AppSize.space[1],
                    ),
                    child: Text(
                      statusMeeting.status,
                      style: kTextHeme.overline?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  );
                })
              ],
            ),
            Spacer(),
            _BuildMeetStat(
              listStatisticData: widget.meetingData.listAttendanceType!,
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildMeetStat extends StatelessWidget {
  final List<StatisticData> listStatisticData;
  const _BuildMeetStat({
    required this.listStatisticData,
  });

  @override
  Widget build(BuildContext context) {
    final statData =
        ReusableFunctionHelper.getStatisticValue(listStatisticData);
    int maxVal = 0;
    statData.values.map((e) => maxVal += e);
    return Column(
      children: [
        Row(
          children: [
            if (statData[1] != 0)
              Flexible(
                flex: statData[1]!,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSize.space[3],
                    ),
                    color: Palette.success,
                  ),
                ),
              ),
            if (statData[3] != 0) ...[
              AppSize.horizontalSpace[0],
              Flexible(
                flex: statData[3]!,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSize.space[3],
                    ),
                    color: Palette.warning,
                  ),
                ),
              ),
            ],
            if (statData[4] != 0) ...[
              AppSize.horizontalSpace[0],
              Flexible(
                flex: statData[4]!,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSize.space[3],
                    ),
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
            if (statData[2] != 0) ...[
              AppSize.horizontalSpace[0],
              Flexible(
                flex: statData[2]!,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSize.space[3],
                    ),
                    color: Palette.danger,
                  ),
                ),
              ),
            ]
          ],
        ),
        AppSize.verticalSpace[2],
        Row(
          children: [
            _DetailCoursePercent(
              absentStatus: AbsentStatus.hadir,
              value: statData[1]!,
            ),
            AppSize.horizontalSpace[2],
            _DetailCoursePercent(
              absentStatus: AbsentStatus.sakit,
              value: statData[3]!,
            ),
            AppSize.horizontalSpace[2],
            _DetailCoursePercent(
              absentStatus: AbsentStatus.izin,
              value: statData[4]!,
            ),
            AppSize.horizontalSpace[2],
            _DetailCoursePercent(
              absentStatus: AbsentStatus.tidakHadir,
              value: statData[2]!,
            ),
          ],
        )
      ],
    );
  }
}

class AbsentData {
  final String title;
  final Color color;
  String? path;

  AbsentData({
    required this.title,
    required this.color,
    this.path,
  });
}

class _DetailCoursePercent extends StatelessWidget {
  final AbsentStatus absentStatus;
  final int value;
  const _DetailCoursePercent({
    required this.absentStatus,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final Map<AbsentStatus, AbsentData> data = {
      AbsentStatus.hadir: AbsentData(
        title: 'Hadir',
        color: Palette.success,
      ),
      AbsentStatus.sakit: AbsentData(title: 'Sakit', color: Palette.warning),
      AbsentStatus.izin: AbsentData(title: 'Izin', color: Colors.blue),
      AbsentStatus.tidakHadir:
          AbsentData(title: 'Tanpa Keterangan', color: Palette.danger),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data[absentStatus]!.title,
          style: kTextHeme.overline?.copyWith(
            color: Palette.onPrimary,
          ),
        ),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              color: data[absentStatus]!.color,
            ),
            AppSize.horizontalSpace[0],
            Text(
              value.toString(),
              style: kTextHeme.overline?.copyWith(
                color: Palette.onPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
