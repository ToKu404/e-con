import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/menu/widgets/class_card.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecture_courses_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _AppBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.space[4]),
      height: 55,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar Kelas',
            style: kTextHeme.headline5?.copyWith(
              color: Palette.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherAbsentPage extends StatefulWidget {
  const TeacherAbsentPage({super.key});

  @override
  State<TeacherAbsentPage> createState() => _TeacherAbsentPageState();
}

class _TeacherAbsentPageState extends State<TeacherAbsentPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 55,
            ),
            Expanded(
              child: Builder(builder: (c) {
                final courseProvider = context.watch<LectureCourseNotifier>();

                if (courseProvider.state == RequestState.loading) {
                  return CustomShimmer(
                      child: Column(
                    children: [
                      AppSize.verticalSpace[4],
                      CardPlaceholder(),
                      AppSize.verticalSpace[4],
                      CardPlaceholder(),
                      AppSize.verticalSpace[4],
                      CardPlaceholder()
                    ],
                  ));
                } else if (courseProvider.state == RequestState.error) {
                  return EconError(errorMessage: courseProvider.error);
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: AppSize.space[4]),
                  shrinkWrap: true,
                  itemCount: courseProvider.listCourse?.length,
                  itemBuilder: (context, index) {
                    final data = courseProvider.listCourse!.elementAt(index);
                    return ClassCard(
                      clazzData: data,
                      onTap: () => Navigator.pushNamed(
                          context, AppRoute.detailCourse,
                          arguments: data),
                    );
                  },
                );
              }),
            ),
          ],
        ),
        _AppBarSection(),
      ],
    );
  }
}
