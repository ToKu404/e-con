import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/history/provider/attendance_history_notifier.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentMeetingHistoryPage extends StatefulWidget {
  final ClazzData clazzData;
  const StudentMeetingHistoryPage({super.key, required this.clazzData});

  @override
  State<StudentMeetingHistoryPage> createState() =>
      _StudentMeetingHistoryPageState();
}

class _StudentMeetingHistoryPageState extends State<StudentMeetingHistoryPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AttendanceHistoryNotifier>(context, listen: false)
          .fetchListStudentAttendance(classId: widget.clazzData.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.clazzData.courseData!.courseName!} ${widget.clazzData.name ?? ''}',
          style: kTextHeme.headline5?.copyWith(
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(child: Builder(builder: (context) {
        final provider = context.watch<AttendanceHistoryNotifier>();

        if (provider.studentAttendanceState == RequestState.loading ||
            provider.listStudentClass == null) {
          return CustomShimmer(
              child: Column(
            children: [
              AppSize.verticalSpace[3],
              CardPlaceholder(
                height: 70,
                horizontalPadding: AppSize.space[3],
              ),
              AppSize.verticalSpace[3],
              CardPlaceholder(
                height: 70,
                horizontalPadding: AppSize.space[3],
              ),
              AppSize.verticalSpace[3],
              CardPlaceholder(
                height: 70,
                horizontalPadding: AppSize.space[3],
              ),
            ],
          ));
        }

        final listAttendanceData = provider.listStudentAttendance;
        return ListView.builder(
          padding: EdgeInsets.all(
            AppSize.space[3],
          ),
          itemCount: listAttendanceData?.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                bottom: AppSize.space[2],
              ),
              width: AppSize.getAppWidth(context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  AppSize.space[3],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  AppSize.space[4],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ReusableFuntionHelper.datetimeToString(
                                listAttendanceData![index].meetingData!.date!),
                            style: kTextHeme.subtitle2?.copyWith(
                              color: Palette.disable,
                            ),
                          ),
                          Text(
                            'Pertemuan ${index + 1}',
                            style: kTextHeme.subtitle1?.copyWith(
                              color: Palette.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            listAttendanceData[index].meetingData!.topics!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: kTextHeme.subtitle2?.copyWith(
                              color: Palette.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 50,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.space[0],
                        vertical: AppSize.space[2],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSize.space[4],
                        ),
                        color: ReusableFuntionHelper.getAttendanceColor(
                                listAttendanceData[index].attendanceType!.id!)
                            .withOpacity(.2),
                      ),
                      child: Center(
                        child: Text(
                          listAttendanceData[index].attendanceType?.name ?? '',
                          style: kTextHeme.subtitle2?.copyWith(
                            color: ReusableFuntionHelper.getAttendanceColor(
                                listAttendanceData[index].attendanceType!.id!),
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      })),
    );
  }
}
