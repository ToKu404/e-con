import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class TeacherBarcodePage extends StatefulWidget {
  final Map args;
  const TeacherBarcodePage({
    super.key,
    required this.args,
  });

  @override
  State<TeacherBarcodePage> createState() => _TeacherBarcodePageState();
}

class _TeacherBarcodePageState extends State<TeacherBarcodePage> {
  late ClazzData clazzData;
  late MeetingData meetingData;

  @override
  void initState() {
    super.initState();
    clazzData = widget.args['classData'];
    meetingData = widget.args['meetingData'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Absen',
          style: kTextHeme.headline5?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.mode_edit_outline_outlined,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      backgroundColor: Palette.primary,
      body: Padding(
        padding: EdgeInsets.all(AppSize.space[3]),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: AppSize.getAppWidth(context) * .75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSize.space[2],
                      ),
                      color: Palette.background,
                    ),
                    padding: EdgeInsets.all(AppSize.space[4]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${clazzData.courseData!.courseName!} (${clazzData.name})',
                          style: kTextHeme.headline5?.copyWith(
                            color: Palette.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Pertemuan ${meetingData.id}',
                          style: kTextHeme.headline5?.copyWith(
                            color: Palette.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            margin: EdgeInsets.all(
                              AppSize.space[3],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppSize.space[2],
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        AppSize.verticalSpace[2],
                        Text(
                          'Berlaku Hingga',
                          style: kTextHeme.subtitle1?.copyWith(
                            color: Palette.onPrimary,
                          ),
                        ),
                        Text(
                          '09:00 12-02-2022',
                          style: kTextHeme.subtitle1?.copyWith(
                            color: Palette.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              text: 'Bagikan',
              onTap: () {},
              textColor: Palette.primary,
              icon: Icons.ios_share_rounded,
              height: 54,
              color: Colors.white,
            ),
            AppSize.verticalSpace[3],
            CustomButton(
              text: 'Unduh',
              onTap: () {},
              icon: Icons.download_rounded,
              height: 54,
              color: Palette.secondary,
            )
          ],
        ),
      ),
    );
  }
}
