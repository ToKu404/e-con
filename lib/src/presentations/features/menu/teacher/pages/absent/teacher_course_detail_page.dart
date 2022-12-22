import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/cpl_lecturer/course_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/course_student_data.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/absent/widgets/teacher_meet_card.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/course_student_notifier.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/meeting_course_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TeacherCourseDetailPage extends StatefulWidget {
  final CourseData courseData;
  const TeacherCourseDetailPage({super.key, required this.courseData});

  @override
  State<TeacherCourseDetailPage> createState() =>
      _TeacherCourseDetailPageState();
}

class _TeacherCourseDetailPageState extends State<TeacherCourseDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      Provider.of<CourseStudentNotifier>(context, listen: false)
        ..getListStudent(widget.courseData.classId!);
      Provider.of<MeetingCourseNotifier>(context, listen: false)
        ..getListMeeting(classId: widget.courseData.classId!);
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
        studentCourseProvider.listStudent == null ||
        meetingProvider.listMeeting!.isEmpty ||
        studentCourseProvider.listStudent!.isEmpty) {
      return EconError(
        errorMessage: 'Data Kosong',
        withScaffold: true,
      );
    }

    final sampleMeeting = meetingProvider.listMeeting!.first;
    final courseDate = ReusableFuntionHelper.datetimeGenerator(
        sampleMeeting.date!, sampleMeeting.startTime!, sampleMeeting.endTime!);

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                TitleSection(
                  className: widget.courseData.className ?? '',
                  courseName: widget.courseData.courseName ?? '',
                  semesterName: '',
                  totalStudent: studentCourseProvider.listStudent!.length,
                  courseDate: courseDate,
                ),
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
              children: [
                TitleSection(
                  className: widget.courseData.className ?? '',
                  courseName: widget.courseData.courseName ?? '',
                  semesterName: '',
                  totalStudent: studentCourseProvider.listStudent!.length,
                  courseDate: courseDate,
                ),
              ],
            )
          ],
        ),
      ),
    );
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
                  courseName,
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
