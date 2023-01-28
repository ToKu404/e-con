import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/path_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/meeting_course_notifier.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:e_con/src/presentations/widgets/fields/input_date_time_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LecturerGenBarcodePage extends StatefulWidget {
  final Map args;

  const LecturerGenBarcodePage({super.key, required this.args});

  @override
  State<LecturerGenBarcodePage> createState() => _LecturerGenBarcodePageState();
}

class _LecturerGenBarcodePageState extends State<LecturerGenBarcodePage> {
  late ClazzData clazzData;
  late MeetingData meetingData;
  late bool isEdit;
  final TextEditingController dateController = TextEditingController();
  DateTime? dateTime;
  bool isNeedLocation = false;

  @override
  void initState() {
    super.initState();
    clazzData = widget.args['classData'];
    meetingData = widget.args['meetingData'];
    isEdit = widget.args['isEdit'];

    if (isEdit) {
      dateController.text = ReusableFunctionHelper.datetimeToString(
          meetingData.validationCodeExpiredDate!,
          isShowTime: true);
      dateTime = meetingData.validationCodeExpiredDate!;
    }
  }

  @override
  void dispose() {
    super.dispose();
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
          icon: const Icon(Icons.close_rounded),
        ),
        title: Text(
          isEdit ? 'Edit QrCode Absen' : 'QrCode Absen',
          style: kTextHeme.headline5?.copyWith(
            color: Palette.black,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        final provider = context.watch<MeetingCourseNotifier>();
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                          clazzData.courseData!.courseName!,
                          style: kTextHeme.headline4?.copyWith(
                            color: Palette.primary,
                          ),
                        ),
                        AppSize.verticalSpace[3],
                        _buildAbsentTile(
                          title: 'Kelas ${clazzData.name} (2019)',
                          iconPath: AssetPath.iconSchool,
                        ),
                        AppSize.verticalSpace[1],
                        _buildAbsentTile(
                          title:
                              '${clazzData.startTime} - ${clazzData.endTime} WITA',
                          iconPath: AssetPath.iconTime,
                        ),
                        AppSize.verticalSpace[1],
                        _buildAbsentTile(
                          title: ReusableFunctionHelper.datetimeToString(
                              meetingData.date!),
                          iconPath: AssetPath.iconDate,
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
                        InputDateTimeField(
                            action: (d) async {
                              dateTime = d;
                            },
                            initialDate: meetingData.date,
                            controller: dateController,
                            hintText: 'Berlaku Hingga'),
                        // AppSize.verticalSpace[2],
                        // DecoratedBox(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(12),
                        //     color: Colors.white,
                        //   ),
                        //   child: CheckboxListTile(
                        //       title: Text(
                        //         'Deteksi Lokasi',
                        //         style: kTextHeme.subtitle1?.copyWith(
                        //           color: Palette.primary,
                        //         ),
                        //       ),
                        //       checkColor: Palette.primary,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12.0),
                        //       ),
                        //       checkboxShape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(4.0),
                        //       ),
                        //       value: isNeedLocation,
                        //       onChanged: (val) {}),
                        // ),
                        AppSize.verticalSpace[3],
                        CustomButton(
                          text: isEdit ? 'Simpan Perubahan' : 'Lanjutkan',
                          onTap: () async {
                            await provider.getValidationCode(
                                meetingId: meetingData.id);
                            if (dateTime != null) {
                              await provider.setAttendanceExpiredDate(
                                  meetingId: meetingData.id,
                                  expiredDate: dateTime!);
                            }
                            if (provider.validationCode != null) {
                              if (isEdit) {
                                await context.read<MeetingCourseNotifier>()
                                  ..getMeetingData(meetingId: meetingData.id);
                                Navigator.pop(context);
                                return;
                              }
                              Navigator.pushNamed(
                                  context, AppRoutes.barcodeAbsent,
                                  arguments: {
                                    'meetingId': meetingData.id,
                                    'classData': clazzData,
                                    'validationCode': provider.validationCode,
                                    'meetingNumber': meetingData.meetingNumber,
                                  });
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

  Widget _buildAbsentTile({required String title, required String iconPath}) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Palette.onPrimary,
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              color: Colors.white,
            ),
          ),
        ),
        AppSize.horizontalSpace[2],
        Expanded(
          child: Text(
            title,
            style: kTextHeme.subtitle1?.copyWith(
              color: Palette.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
