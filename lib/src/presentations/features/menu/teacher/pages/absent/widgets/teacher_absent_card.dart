import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:flutter/material.dart';

class TeacherAbsentCard extends StatelessWidget {
  final ClazzData clazzData;
  const TeacherAbsentCard({super.key, required this.clazzData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoute.detailCourse,
          arguments: clazzData),
      child: Container(
        width: AppSize.getAppWidth(context),
        margin: EdgeInsets.only(
          bottom: AppSize.space[3],
          left: AppSize.space[4],
          right: AppSize.space[4],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppSize.space[3],
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(
                    AppSize.space[4],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            clazzData.courseData!.courseName ?? '',
                            style: kTextHeme.subtitle1?.copyWith(
                              color: Palette.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Kelas ${clazzData.name}',
                            style: kTextHeme.subtitle1?.copyWith(
                              color: Palette.disable,
                            ),
                          ),
                          Text(
                            'Senin ${clazzData.startTime}-${clazzData.endTime} WITA',
                            style: kTextHeme.subtitle1?.copyWith(
                              color: Palette.onPrimary,
                            ),
                          ),
                          AppSize.verticalSpace[3],
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSize.space[3],
                              vertical: AppSize.space[1],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppSize.space[5],
                              ),
                              color: Palette.primary,
                            ),
                            child: Text(
                              'Berjalan',
                              style: kTextHeme.subtitle2?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(size.width / 3, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..moveTo(size.width / 3, 0)
      ..close();

    // path.lineTo(size.width, size.height);
    // path.lineTo(size.height, size.width);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
