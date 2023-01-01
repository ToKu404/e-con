import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/absent/widgets/teacher_absent_card.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/lecture_courses_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class TeacherAbsentPage extends StatefulWidget {
  const TeacherAbsentPage({super.key});

  @override
  State<TeacherAbsentPage> createState() => _TeacherAbsentPageState();
}

class _TeacherAbsentPageState extends State<TeacherAbsentPage> {
  
  @override
  Widget build(BuildContext context) {
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
