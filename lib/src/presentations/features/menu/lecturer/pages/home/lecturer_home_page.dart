import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/home/widgets/teacher_task_card.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecture_courses_notifier.dart';
import 'package:e_con/src/presentations/widgets/default_appbar.dart';
import 'package:e_con/src/presentations/widgets/header_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LecturerHomePage extends StatefulWidget {
  const LecturerHomePage({super.key});

  @override
  State<LecturerHomePage> createState() => _LecturerHomePageState();
}

class _LecturerHomePageState extends State<LecturerHomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LectureCourseNotifier>();
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pengingat Harian',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Palette.black,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            ReusableFuntionHelper.datetimeToString(
                                DateTime.now()),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Palette.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(),
                    Builder(builder: (context) {
                      if (provider.state == RequestState.loading ||
                          provider.listClazz == null) {
                        return Center();
                      }

                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: 12),
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const TeacherTaskCard();
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
        DefaultAppBar(
          title: '',
          action: Padding(
            padding: EdgeInsets.only(right: AppSize.space[2]),
            child: ElevatedButton.icon(
              label: Text(
                'Buka SIFA',
                style: kTextHeme.subtitle1?.copyWith(color: Palette.white),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Palette.primaryVariant,
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.cplWebview);
              },
              icon: const Icon(
                Icons.open_in_new,
                size: 16,
                color: Palette.white,
              ),
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: AppSize.space[2]),
            child: HeaderLogo(),
          ),
        )
      ],
    );
  }
}
