import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/absent/widgets/teacher_absent_card.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/lecture_courses_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherAbsentPage extends StatelessWidget {
  const TeacherAbsentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<LectureCourseNotifier>();

    if (courseProvider.state == RequestState.loading) {
      return CustomShimmer(
          child: Column(
        children: [
          CardPlaceholder(),
          AppSize.verticalSpace[3],
          CardPlaceholder(),
          AppSize.verticalSpace[3],
          CardPlaceholder()
        ],
      ));
    } else if (courseProvider.state == RequestState.error) {
      return EconError(errorMessage: courseProvider.error);
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSize.space[4]),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: courseProvider.listCourse?.length,
        itemBuilder: (context, index) {
          final data = courseProvider.listCourse!.elementAt(index);

          return TeacherAbsentCard(
            courseData: data,
          );
        },
      ),
    );
  }
}
