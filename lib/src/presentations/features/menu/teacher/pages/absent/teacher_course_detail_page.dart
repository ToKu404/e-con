import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/absent/widgets/teacher_meet_card.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TeacherCourseDetailPage extends StatelessWidget {
  const TeacherCourseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const TitleSection(),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    padding: EdgeInsets.all(
                      AppSize.space[3],
                    ),
                    itemBuilder: (context, index) {
                      return const TeacherMeetCard();
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: const [
                TitleSection(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSize.space[4],
        horizontal: AppSize.space[2],
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 0),
            blurRadius: 15,
            color: Colors.black12,
          )
        ],
      ),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.space[4]),
            child: Column(
              children: [
                AppSize.verticalSpace[4],
                const _BuildCourseTile(
                  iconPath: 'assets/icons/class.svg',
                  title: 'Kelas A',
                ),
                AppSize.verticalSpace[2],
                const _BuildCourseTile(
                  iconPath: 'assets/icons/school.svg',
                  title: 'Angkatan 2019',
                ),
                AppSize.verticalSpace[2],
                const _BuildCourseTile(
                  iconPath: 'assets/icons/schedule.svg',
                  title: 'Senin, 10.00 - 12.00 WITA',
                ),
                AppSize.verticalSpace[4],
                CustomButton(
                  text: '54 Mahasiswa',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.listStudent);
                  },
                  height: 50,
                  iconPath: 'assets/icons/user.svg',
                )
              ],
            ),
          ),
        ],
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
          iconPath,
          width: 24,
          height: 24,
          color: Palette.primary,
        ),
        AppSize.horizontalSpace[2],
        Expanded(
          child: Text(
            title,
            style: kTextHeme.subtitle1?.copyWith(
              color: Palette.primary,
            ),
          ),
        ),
      ],
    );
  }
}
