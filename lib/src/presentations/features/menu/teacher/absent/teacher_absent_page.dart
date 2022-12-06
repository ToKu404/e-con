import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/src/presentations/features/menu/teacher/absent/widgets/teacher_absent_card.dart';
import 'package:e_con/src/presentations/features/menu/teacher/activity/widgets/teacher_task_card.dart';
import 'package:flutter/widgets.dart';

class TeacherAbsentPage extends StatelessWidget {
  const TeacherAbsentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSize.space[4]),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const TeacherAbsentCard();
        },
      ),
    );
  }
}