import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/absent/widgets/teacher_meet_card.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/course_student_notifier.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/meeting_course_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_empty.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TeacherCourseDetailPage extends StatefulWidget {
  final ClazzData clazzData;
  const TeacherCourseDetailPage({super.key, required this.clazzData});

  @override
  State<TeacherCourseDetailPage> createState() =>
      _TeacherCourseDetailPageState();
}

class _TeacherCourseDetailPageState extends State<TeacherCourseDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CourseStudentNotifier>(context, listen: false)
        ..getListStudent(widget.clazzData.id!);
      Provider.of<MeetingCourseNotifier>(context, listen: false)
        ..getListMeeting(classId: widget.clazzData.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final meetingProvider = context.watch<MeetingCourseNotifier>();
    final studentCourseProvider = context.watch<CourseStudentNotifier>();

    if (meetingProvider.state == RequestState.loading ||
        studentCourseProvider.state == RequestState.loading) {
      return EconLoading(
        withScaffold: true,
      );
    } else if (meetingProvider.state == RequestState.error ||
        studentCourseProvider.state == RequestState.error) {
      return EconError(
        errorMessage: meetingProvider.error,
        withScaffold: true,
      );
    }

    if (meetingProvider.listMeeting == null ||
        studentCourseProvider.listStudent == null) {
      return EconError(
        errorMessage: 'Data Kosong',
        withScaffold: true,
      );
    }

    final listMeeting = meetingProvider.listMeeting!;

    final courseDate =
        '${widget.clazzData.startTime}-${widget.clazzData.endTime}';

    final ValueNotifier<bool> isShowDetail = ValueNotifier(false);

    return ValueListenableBuilder(
        valueListenable: isShowDetail,
        builder: (context, state, _) {
          return Scaffold(
            backgroundColor: Palette.background,
            floatingActionButton: ElevatedButton.icon(
              icon: Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.primary,
                foregroundColor: Palette.white,
              ),
              label: Text('Tambah Pertemuan'),
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.addNewMeeting,
                    arguments: widget.clazzData);
              },
            ),
            appBar: AppBar(
              backgroundColor: Palette.white,
              shadowColor: state ? null : Colors.black38,
              surfaceTintColor: Palette.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                ),
              ),
              title: Text(
                widget.clazzData.courseData!.courseName ?? '',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kTextHeme.headline5?.copyWith(
                  color: Palette.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    isShowDetail.value = !isShowDetail.value;
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: ValueListenableBuilder(
                  valueListenable: isShowDetail,
                  builder: (context, state, _) {
                    return Stack(
                      children: [
                        Column(
                          children: [
                            state
                                ? TitleSection(
                                    className: widget.clazzData.name ?? '',
                                    courseName: widget
                                            .clazzData.courseData!.courseName ??
                                        '',
                                    semesterName: '',
                                    totalStudent: studentCourseProvider
                                        .listStudent!.length,
                                    courseDate: courseDate,
                                  )
                                : SizedBox.shrink(),
                            Expanded(
                              child: listMeeting.isEmpty
                                  ? EconEmpty(
                                      emptyMessage:
                                          'Silahkan buat meeting terlebih dahulu!')
                                  : ListView.builder(
                                      itemCount: listMeeting.length,
                                      padding: EdgeInsets.all(
                                        AppSize.space[3],
                                      ),
                                      itemBuilder: (context, index) {
                                        return TeacherMeetCard(
                                          meetingData: listMeeting[index],
                                          classData: widget.clazzData,
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            state
                                ? TitleSection(
                                    className: widget.clazzData.name ?? '',
                                    courseName: widget
                                            .clazzData.courseData!.courseName ??
                                        '',
                                    semesterName: '',
                                    totalStudent: studentCourseProvider
                                        .listStudent!.length,
                                    courseDate: courseDate,
                                  )
                                : SizedBox.shrink(),
                          ],
                        )
                      ],
                    );
                  }),
            ),
          );
        });
  }
}

class TitleSection extends StatelessWidget {
  final String courseName;
  final String className;
  final String semesterName;
  final int totalStudent;
  final String courseDate;
  const TitleSection({
    required this.className,
    required this.courseName,
    required this.semesterName,
    required this.totalStudent,
    required this.courseDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Palette.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 0),
            blurRadius: 15,
            color: Colors.black12,
          )
        ],
      ),
      padding: EdgeInsets.only(
          left: AppSize.space[6],
          right: AppSize.space[6],
          bottom: AppSize.space[4]),
      child: Column(
        children: [
          AppSize.verticalSpace[4],
          _BuildCourseTile(
            iconPath: 'assets/icons/class.svg',
            title: className,
          ),
          AppSize.verticalSpace[2],
          _BuildCourseTile(
            iconPath: 'assets/icons/school.svg',
            title: semesterName,
          ),
          AppSize.verticalSpace[2],
          _BuildCourseTile(
            iconPath: 'assets/icons/schedule.svg',
            title: courseDate,
          ),
          AppSize.verticalSpace[4],
          CustomButton(
            text: '$totalStudent Mahasiswa',
            onTap: () {
              Navigator.pushNamed(context, AppRoute.listStudent);
            },
            height: 50,
            iconPath: 'assets/icons/user.svg',
          )
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
