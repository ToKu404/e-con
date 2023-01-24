import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/menu/widgets/class_card.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecture_courses_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/default_appbar.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LecturerAbsentPage extends StatefulWidget {
  const LecturerAbsentPage({super.key});

  @override
  State<LecturerAbsentPage> createState() => _LecturerAbsentPageState();
}

class _LecturerAbsentPageState extends State<LecturerAbsentPage> {
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
                  itemCount: courseProvider.listClazz?.length,
                  itemBuilder: (context, index) {
                    final data = courseProvider.listClazz!.elementAt(index);
                    return ClassCard(
                      clazzData: data,
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.detailCourse,
                          arguments: data),
                    );
                  },
                );
              }),
            ),
          ],
        ),
        DefaultAppBar(title: 'Daftar Kelas'),
      ],
    );
  }
}