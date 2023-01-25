import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/final_exam_helper.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/data/models/final_exam/helpers/seminar_type.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:flutter/material.dart';

class LecturerSeminarCard extends StatelessWidget {
  final SeminarData seminarData;
  const LecturerSeminarCard({
    required this.seminarData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.lecturerDetailSeminar,
            arguments: seminarData.seminarId);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        width: AppSize.getAppWidth(context),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Palette.background,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            AppSize.space[3],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Palette.field,
                ),
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.calendar_month_outlined,
                  color: Palette.black,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            seminarType[seminarData.examType!]!,
                            style: kTextHeme.subtitle1?.copyWith(
                              color: Palette.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          ReusableFuntionHelper.datetimeToString(
                              seminarData.date!,
                              format: 'dd MMM'),
                          style: kTextHeme.overline?.copyWith(
                            color: Palette.black,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      seminarData.finalExamData!.student!.name!,
                      style: kTextHeme.subtitle2?.copyWith(
                        color: Palette.disable,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      seminarData.finalExamData!.student!.nim!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: kTextHeme.subtitle2?.copyWith(
                        color: Palette.disable,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
