import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecturer_today_meeting_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/meeting_course_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:e_con/src/presentations/widgets/fields/input_date_field.dart';
import 'package:e_con/src/presentations/widgets/fields/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LecturerAddMeetingPage extends StatefulWidget {
  final ClazzData clazzData;
  const LecturerAddMeetingPage({super.key, required this.clazzData});

  @override
  State<LecturerAddMeetingPage> createState() => _LecturerAddMeetingPageState();
}

class _LecturerAddMeetingPageState extends State<LecturerAddMeetingPage> {
  final TextEditingController topicController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final ValueNotifier<bool> showLoading = ValueNotifier(false);
  DateTime? meetingDate;

  @override
  void dispose() {
    super.dispose();
    topicController.dispose();
    showLoading.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final classData = widget.clazzData;
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'Tambah Pertemuan',
          style: kTextHeme.headline5?.copyWith(
            color: Palette.black,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return ValueListenableBuilder(
            valueListenable: showLoading,
            builder: (context, value, _) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: AppSize.getAppWidth(context),
                              padding: EdgeInsets.all(AppSize.space[3]),
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Matakuliah',
                                    style: kTextHeme.subtitle1
                                        ?.copyWith(color: Palette.disable),
                                  ),
                                  Text(
                                    classData.courseData!.courseName!,
                                    style: kTextHeme.headline4?.copyWith(
                                      color: Palette.primary,
                                    ),
                                  ),
                                  Text(
                                    'Kelas ${classData.name} (2019)',
                                    style: kTextHeme.subtitle1?.copyWith(
                                      color: Palette.onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AbsorbPointer(
                              absorbing: value,
                              child: Padding(
                                padding: EdgeInsets.all(
                                  AppSize.space[3],
                                ),
                                child: Column(
                                  children: [
                                    InputField(
                                      controller: topicController,
                                      text: 'Topik Pertemuan',
                                    ),
                                    AppSize.verticalSpace[2],
                                    InputDateField(
                                      controller: dateController,
                                      action: (date) async {
                                        meetingDate = date;
                                      },
                                      hintText: 'Waktu Pertemuan',
                                    ),
                                    AppSize.verticalSpace[4],
                                    CustomButton(
                                      text: 'Simpan',
                                      onTap: () async {
                                        if (topicController.text.isNotEmpty ||
                                            dateController.text.isNotEmpty) {
                                          showLoading.value = true;
                                          if (dateController.text.isNotEmpty &&
                                              topicController.text.isNotEmpty &&
                                              meetingDate != null) {
                                            final prov = context
                                                .read<MeetingCourseNotifier>();
                                            await prov.createNewMeeting(
                                                classId: classData.id!,
                                                topic: topicController.text,
                                                meetingDate: meetingDate!);
                                            await prov.getListMeeting(
                                                classId: classData.id!);
                                            final activityProv = context.read<
                                                LecturerTodayMeetingNotifier>();
                                            activityProv
                                                .fetchAllMeetingByDate();
                                            if (mounted) {
                                              showLoading.value = false;
                                              Navigator.pop(context);
                                            }
                                          }
                                        }
                                      },
                                      height: 54,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (value) EconLoading()
                ],
              );
            });
      }),
    );
  }
}
