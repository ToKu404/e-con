import 'dart:async';

import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/meeting_course_notifier.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:e_con/src/presentations/widgets/fields/input_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TeacherAddMeetingPage extends StatefulWidget {
  final int classId;
  const TeacherAddMeetingPage({super.key, required this.classId});

  @override
  State<TeacherAddMeetingPage> createState() => _TeacherAddMeetingPageState();
}

class _TeacherAddMeetingPageState extends State<TeacherAddMeetingPage> {
  final TextEditingController topicController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? meetingDate;

  @override
  void dispose() {
    super.dispose();
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
          'Tambah Pertemuan',
          style: kTextHeme.headline5?.copyWith(
            color: Palette.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
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
                          'Matematika Dasar 1',
                          style: kTextHeme.headline4?.copyWith(
                            color: Palette.primary,
                          ),
                        ),
                        Text(
                          'Kelas A (2019)',
                          style: kTextHeme.subtitle1?.copyWith(
                            color: Palette.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
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
                        ),
                        AppSize.verticalSpace[3],
                        CustomButton(
                          text: 'Simpan',
                          onTap: () {
                            if (dateController.text.isNotEmpty &&
                                topicController.text.isNotEmpty &&
                                meetingDate != null) {
                              final prov =
                                  context.read<MeetingCourseNotifier>();
                              prov.createNewMeeting(
                                  classId: widget.classId,
                                  topic: topicController.text,
                                  meetingDate: meetingDate!);
                            }
                          },
                          height: 54,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class InputDateField extends StatefulWidget {
  final TextEditingController controller;
  final FutureOr<void> Function(DateTime date)? action;
  const InputDateField(
      {super.key, required this.action, required this.controller});

  @override
  State<InputDateField> createState() => _InputDateFieldState();
}

class _InputDateFieldState extends State<InputDateField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: () async {
        final selected = await showDatePicker(
          context: context,
          initialDate: widget.controller.text.isEmpty
              ? DateTime.now()
              : DateFormat("EEEE, dd MMMM yyyy", "id_ID")
                  .parse(widget.controller.text),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(
              days: 30,
            ),
          ),
        );

        if (selected == null) return;
        setState(() {
          widget.controller.text =
              DateFormat('EEEE, dd MMMM yyyy', "id_ID").format(selected);
          widget.action!.call(selected);
        });
      },
      keyboardType: TextInputType.text,
      style: kTextHeme.subtitle1?.copyWith(
        color: Palette.onPrimary,
      ),
      cursorColor: Palette.primary,
      decoration: InputDecoration(
        hintText: 'Waktu Pertemuan',
        hintStyle: kTextHeme.subtitle1,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Palette.background),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Palette.primary),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
