import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/activity/widgets/teacher_task_card.dart';
import 'package:e_con/src/presentations/widgets/header_logo.dart';
import 'package:flutter/material.dart';

class TeacherActivityPage extends StatelessWidget {
  const TeacherActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 12),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const TeacherTaskCard();
                },
              ),
            ),
          ],
        ),
        _AppBarSection(),
      ],
    );
  }
}

class _AppBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.all(AppSize.space[2]),
      width: AppSize.getAppWidth(context),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            offset: const Offset(1, 2),
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          HeaderLogo(),
          Spacer(),
          ElevatedButton.icon(
            label: Text(
              'Buka SIFA',
              style: kTextHeme.subtitle1?.copyWith(color: Palette.white),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Palette.primaryVariant,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.cplWebview);
            },
            icon: const Icon(
              Icons.open_in_new,
              size: 16,
              color: Palette.white,
            ),
          ),
        ],
      ),
    );
  }
}
