import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TeacherCourseDetailPage extends StatelessWidget {
  const TeacherCourseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: AppSize.space[4],
                horizontal: AppSize.space[2],
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Matematika Dasar 1',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kTextHeme.headline5?.copyWith(
                            color: Palette.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      _BuildCourseTile(
                        iconPath: 'assets/icons/class.svg',
                        title: 'Kelas A',
                      ),
                      _BuildCourseTile(
                        iconPath: 'assets/icons/school.svg',
                        title: 'Angkatan 2019',
                      ),
                      _BuildCourseTile(
                        iconPath: 'assets/icons/schedule.svg',
                        title: 'Senin, 10.00 - 12.00 WITA',
                      ),
                      AppSize.verticalSpace[2],
                      CustomButton(text: '54 Mahasiswa', onTap: () {}, height: 50, iconPath: 'assets/',)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildCourseTile extends StatelessWidget {
  final String title;
  final String iconPath;
  const _BuildCourseTile({
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/class.svg',
          width: 24,
          height: 24,
        ),
        AppSize.horizontalSpace[3],
        Expanded(
          child: Text(
            'Kelas A',
            style: kTextHeme.subtitle1,
          ),
        ),
      ],
    );
  }
}
