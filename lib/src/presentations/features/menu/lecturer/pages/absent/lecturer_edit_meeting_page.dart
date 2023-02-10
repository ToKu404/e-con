import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
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

class LecturerEditMeetingPage extends StatefulWidget {
  final Map args;
  const LecturerEditMeetingPage({
    super.key,
    required this.args,
  });

  @override
  State<LecturerEditMeetingPage> createState() =>
      _LecturerEditMeetingPageState();
}

class _LecturerEditMeetingPageState extends State<LecturerEditMeetingPage> {
  late ClazzData classData;
  late String topic;
  late DateTime date;
  late int meetingId;

  final TextEditingController topicController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? meetingDate;
  final ValueNotifier<bool> showLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    classData = widget.args['classData'];
    topic = widget.args['topic'];
    date = widget.args['date'];
    meetingId = widget.args['meetingId'];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      topicController.text = topic;
      meetingDate = date;
      dateController.text = ReusableFunctionHelper.datetimeToString(date);
    });
  }

  @override
  void dispose() {
    super.dispose();
    showLoading.dispose();
    topicController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Palette.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'Edit Pertemuan',
          style: kTextHeme.headline5?.copyWith(
            color: Palette.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: showLoading,
          builder: (context, value, _) {
            return LayoutBuilder(builder: (context, constraint) {
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
                                      text: 'Edit Pertemuan',
                                    ),
                                    AppSize.verticalSpace[2],
                                    InputDateField(
                                      controller: dateController,
                                      action: (date) async {
                                        meetingDate = date;
                                      },
                                      hintText: 'Waktu Pertemuan',
                                    ),
                                    AppSize.verticalSpace[3],
                                    CustomButton(
                                      text: 'Simpan Perubahan',
                                      onTap: () async {
                                        if (topicController.text.isNotEmpty ||
                                            dateController.text.isNotEmpty) {
                                          showLoading.value = true;

                                          if (dateController.text.isNotEmpty &&
                                              topicController.text.isNotEmpty &&
                                              meetingDate != null) {
                                            final prov = context
                                                .read<MeetingCourseNotifier>();
                                            await prov.editMeeting(
                                              classId: classData.id!,
                                              topic: topicController.text,
                                              meetingDate: meetingDate!,
                                              meetingId: meetingId,
                                            );
                                            await prov.getListMeeting(
                                                classId: classData.id!);
                                            final activityProv = context.read<
                                                LecturerTodayMeetingNotifier>();
                                            activityProv
                                                .fetchAllMeetingByDate();
                                            if (mounted) {
                                              showLoading.value = false;
                                              Navigator.pop(context);
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
