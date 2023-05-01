import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/widgets/course_participant_card.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_empty.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/course_student_notifier.dart';

class LecturerCourseMember extends StatefulWidget {
  final int classId;
  const LecturerCourseMember({super.key, required this.classId});

  @override
  State<LecturerCourseMember> createState() => _LecturerCourseMemberState();
}

class _LecturerCourseMemberState extends State<LecturerCourseMember> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CourseStudentNotifier>(context, listen: false)
        ..getListStudent(widget.classId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Palette.primary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Peserta Matakuliah',
          style: kTextHeme.headline5?.copyWith(
            fontWeight: FontWeight.bold,
            color: Palette.black,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            context
                .read<CourseStudentNotifier>()
                .getListStudent(widget.classId),
          ]);
        },
        child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const AlwaysScrollableScrollPhysics(
              parent: ClampingScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: Builder(builder: (context) {
                  final studentCourseProvider =
                      context.watch<CourseStudentNotifier>();

                  if (studentCourseProvider.state == RequestState.loading) {
                    return Padding(
                      padding: EdgeInsets.all(AppSize.space[4]),
                      child: CustomShimmer(
                          child: Column(
                        children: [
                          CardPlaceholder(
                            height: 65,
                            horizontalPadding: 0,
                          ),
                          AppSize.verticalSpace[4],
                          CardPlaceholder(
                            height: 65,
                            horizontalPadding: 0,
                          ),
                          AppSize.verticalSpace[4],
                          CardPlaceholder(
                            height: 65,
                            horizontalPadding: 0,
                          )
                        ],
                      )),
                    );
                  } else if (studentCourseProvider.state ==
                          RequestState.error ||
                      studentCourseProvider.listStudent == null) {
                    return EconError(
                      errorMessage: studentCourseProvider.error,
                    );
                  } else if (studentCourseProvider.listStudent!.isEmpty) {
                    return EconEmpty(
                        emptyMessage:
                            'Data peserta matakuliah belum ditambahkan');
                  }

                  final listStudent = studentCourseProvider.listStudent!;
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listStudent.length,
                    padding: EdgeInsets.all(AppSize.space[4]),
                    itemBuilder: (context, index) {
                      return CourseParticipantCard(
                          studentData: listStudent[index]);
                    },
                  );
                }),
              ),
            ]),
      ),
    );
  }
}
