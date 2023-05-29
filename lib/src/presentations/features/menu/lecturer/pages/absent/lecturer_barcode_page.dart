import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/services/image_service.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/widgets/pretier_qr_widget.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/meeting_course_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class LecturerBarcodeKey {
  static final GlobalKey repaintKeyQr = GlobalKey(debugLabel: 'rqr');
}

class LecturerBarcodePage extends StatefulWidget {
  final Map args;
  const LecturerBarcodePage({
    super.key,
    required this.args,
  });

  @override
  State<LecturerBarcodePage> createState() => _LecturerBarcodePageState();
}

class _LecturerBarcodePageState extends State<LecturerBarcodePage> {
  late ClazzData clazzData;
  late int meetingId;
  late int meetingNumber;
  late String validationCode;

  @override
  void initState() {
    super.initState();
    clazzData = widget.args['classData'];
    meetingId = widget.args['meetingId'];
    meetingNumber = widget.args['meetingNumber'];

    validationCode = widget.args['validationCode'];
    Future.microtask(() {
      Provider.of<MeetingCourseNotifier>(context, listen: false)
        ..getMeetingData(meetingId: meetingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MeetingCourseNotifier>();

    if (provider.getMeetingDataState == RequestState.loading ||
        provider.meetingData == null) {
      return EconLoading(
        withScaffold: true,
      );
    } else if (provider.getMeetingDataState == RequestState.error) {
      return EconError(errorMessage: provider.error);
    }
    final meetingData = provider.meetingData!;
    meetingData.setMeetingNumber = meetingNumber;

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
            if (meetingData.validationCodeExpiredDate != null)
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
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.genBarcode, arguments: {
                'meetingData': meetingData,
                'classData': clazzData,
                'isEdit': true,
              });
            },
          ),
        ],
      ),
      backgroundColor: Palette.primary,
      body: Padding(
        padding: EdgeInsets.all(AppSize.space[3]),
        child: Column(
          children: [
            Expanded(
              child: RepaintBoundary(
                key: LecturerBarcodeKey.repaintKeyQr,
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
                              height: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Pertemuan ${meetingData.meetingNumber}',
                            style: kTextHeme.headline5?.copyWith(
                                color: Palette.black,
                                fontWeight: FontWeight.w300),
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
                              child: BarcodeBox(
                                data: '${meetingData.id} ${validationCode}',
                                backgroundColor: Colors.white,
                                color: Colors.black,
                                width: 200,
                                height: 200,
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
                            ReusableFunctionHelper.datetimeToString(
                                meetingData.validationCodeExpiredDate!,
                                format: 'HH:mm dd-MM-yyyy'),
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
            ),
            CustomButton(
              text: 'Bagikan',
              onTap: () async {
                final byte = await captureWidget(
                  LecturerBarcodeKey.repaintKeyQr.currentContext!,
                );

                if (byte == null || byte.isEmpty) {
                  throw Exception('Capture image failed');
                }
                final imagePath = await saveFileToTemp(byte);
                if (imagePath.isEmpty) {
                  throw Exception('Failed save image to temp');
                }
                Share.shareXFiles([XFile(imagePath)]);
              },
              textColor: Palette.primary,
              icon: Icons.ios_share_rounded,
              height: 54,
              color: Colors.white,
            ),
            AppSize.verticalSpace[3],
            CustomButton(
              text: 'Unduh',
              onTap: () async {
                final byte = await captureWidget(
                  LecturerBarcodeKey.repaintKeyQr.currentContext!,
                );

                if (byte == null || byte.isEmpty) {
                  throw Exception('Capture image failed');
                } else {
                  bool isSuccess = await takePicture(byte);
                  if (isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'Qr code successfully saved in the gallery',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    throw Exception('Capture image failed');
                  }
                }
              },
              icon: Icons.download_rounded,
              height: 54,
              color: Palette.primaryVariant,
            )
          ],
        ),
      ),
    );
  }
}
