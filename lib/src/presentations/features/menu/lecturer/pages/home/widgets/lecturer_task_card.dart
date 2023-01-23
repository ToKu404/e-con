import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:flutter/material.dart';

class TeacherTaskCard extends StatelessWidget {
  final MeetingData meetingData;
  const TeacherTaskCard({super.key, required this.meetingData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.space[4],
      ),
      width: AppSize.getAppWidth(context),
      margin: EdgeInsets.only(
        bottom: AppSize.space[3],
      ),
      child: Row(
        children: [
          Flexible(
            flex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${meetingData.clazzData!.startTime} AM',
                  style: kTextHeme.headline5,
                ),
                Text(
                  '${meetingData.clazzData!.endTime}  AM',
                  style: kTextHeme.subtitle1?.copyWith(
                    color: Palette.disable,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          AppSize.horizontalSpace[3],
          Expanded(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            AppSize.space[3],
                          ),
                          bottomLeft: Radius.circular(
                            AppSize.space[3],
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(
                        AppSize.space[3],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meetingData
                                      .clazzData!.courseData!.courseName!,
                                  style: kTextHeme.subtitle1?.copyWith(
                                    color: Palette.primary,
                                  ),
                                ),
                                Text(
                                  meetingData.topics ?? '',
                                  style: kTextHeme.subtitle2?.copyWith(
                                    color: Palette.onPrimary,
                                    height: 1.2,
                                  ),
                                ),
                                AppSize.verticalSpace[3],
                                Text(
                                  'Kelas ${meetingData.clazzData!.name}',
                                  style: kTextHeme.subtitle1?.copyWith(
                                    color: Palette.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 4,
                    color: Palette.primaryVariant,
                  ),
                  Container(
                    width: 6,
                    decoration: BoxDecoration(
                      color: Palette.primary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          AppSize.space[3],
                        ),
                        bottomRight: Radius.circular(
                          AppSize.space[3],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
