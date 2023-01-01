import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TeacherMeetCard extends StatelessWidget {
  final MeetingData meetingData;
  const TeacherMeetCard({
    super.key,
    required this.meetingData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoute.detailMeet,
          arguments: meetingData.id),
      child: Container(
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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('EEEE, dd MMMM yyyy', "id_ID")
                            .format(meetingData.date!),
                        style: kTextHeme.overline?.copyWith(
                          color: Palette.disable,
                        ),
                      ),
                      Text(
                        'Pertemuan ${meetingData.id}',
                        style: kTextHeme.subtitle1?.copyWith(
                          color: Palette.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        meetingData.topics ?? '-',
                        style: kTextHeme.overline?.copyWith(
                          color: Palette.disable,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSize.space[5],
                    ),
                    color: Palette.primary,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.space[3],
                    vertical: AppSize.space[1],
                  ),
                  child: Text(
                    'Selesai',
                    style: kTextHeme.overline?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            AppSize.verticalSpace[3],
            Row(
              children: [
                Flexible(
                  flex: 1,
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
                AppSize.horizontalSpace[0],
                Flexible(
                  flex: 2,
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
                AppSize.horizontalSpace[0],
                Flexible(
                  flex: 3,
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
              ],
            ),
            AppSize.verticalSpace[2],
            Row(
              children: [
                const _DetailCoursePercent(
                  absentStatus: AbsentStatus.hadir,
                  value: 12,
                ),
                AppSize.horizontalSpace[2],
                const _DetailCoursePercent(
                  absentStatus: AbsentStatus.izin,
                  value: 2,
                ),
                AppSize.horizontalSpace[2],
                const _DetailCoursePercent(
                  absentStatus: AbsentStatus.tidakHadir,
                  value: 4,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

enum AbsentStatus { hadir, izin, tidakHadir, sakit }

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
      AbsentStatus.izin: AbsentData(title: 'Izin', color: Palette.warning),
      AbsentStatus.tidakHadir:
          AbsentData(title: 'Tidak Hadir', color: Palette.danger),
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
