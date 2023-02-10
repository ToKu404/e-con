import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/final_exam_helper.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:flutter/material.dart';

class TeacherTodaySeminarCard extends StatelessWidget {
  final SeminarData seminarData;
  const TeacherTodaySeminarCard({super.key, required this.seminarData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.lecturerDetailSeminar,
            arguments: seminarData.seminarId);
      },
      child: Container(
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
                    '${seminarData.startTime} AM',
                    style: kTextHeme.headline5,
                  ),
                  Text(
                    '${seminarData.endTime}  AM',
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
                                    seminarType[seminarData.examType!]!,
                                    style: kTextHeme.subtitle1?.copyWith(
                                      color: Palette.secondary,
                                    ),
                                  ),
                                  Text(
                                    seminarData.finalExamData!.title!,
                                    style: kTextHeme.subtitle2?.copyWith(
                                      color: Palette.primaryVariant,
                                      height: 1.2,
                                    ),
                                  ),
                                  AppSize.verticalSpace[3],
                                  Text(
                                    seminarData.finalExamData!.student!.name!,
                                    style: kTextHeme.subtitle1?.copyWith(
                                      color: Palette.primaryVariant,
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
                        color: Palette.secondary,
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
      ),
    );
  }
}
