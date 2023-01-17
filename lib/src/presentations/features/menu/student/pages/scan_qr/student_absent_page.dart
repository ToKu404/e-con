import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/menu/providers/attendance_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/scan_qr/provider/qr_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/scan_qr/widgets/ripple_location.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/scan_qr/widgets/scan_qr_section.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_profile_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/placeholders/text_placeholder.dart';
import 'package:e_con/src/presentations/widgets/success_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class StudentAbsentPage extends StatelessWidget {
  const StudentAbsentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: const [
                _AppBarSection(),
                Expanded(
                  child: _BodySection(),
                ),
              ],
            ),
            const Positioned(
              left: 0,
              top: 0,
              child: _AppBarSection(),
            )
          ],
        ),
      ),
    );
  }
}

class _AppBarSection extends StatelessWidget {
  const _AppBarSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.space[4],
        vertical: AppSize.space[2],
      ),
      width: AppSize.getAppWidth(context),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            offset: const Offset(1, 0),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close_rounded,
                  size: 24,
                ),
              ),
              Text(
                'Scan Absen',
                style: kTextHeme.headline5?.copyWith(
                  color: Palette.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 50,
                height: 50,
                child: RippleAnimation(
                  size: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BodySection extends StatelessWidget {
  const _BodySection();

  @override
  Widget build(BuildContext context) {
    return Consumer<QrNotifier>(
      builder: (context, value, child) {
        return Stack(
          children: <Widget>[
            const Positioned.fill(
              child: ScanQrSection(),
            ),
            if (value.qrData != null) AttendanceDetailSection(),
          ],
        );
      },
    );
  }
}

class AttendanceDetailSection extends StatefulWidget {
  const AttendanceDetailSection({super.key});

  @override
  State<AttendanceDetailSection> createState() =>
      _AttendanceDetailSectionState();
}

class _AttendanceDetailSectionState extends State<AttendanceDetailSection> {
  @override
  Widget build(BuildContext context) {
    final qrProvider = context.watch<QrNotifier>();
    final studentProvider = context.watch<StudentProfileNotifier>();
    final attendanceProvider = context.watch<AttendanceNotifier>();

    return Positioned(
      bottom: 0,
      child: Container(
        width: AppSize.getAppWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.space[2]),
            topRight: Radius.circular(AppSize.space[2]),
          ),
          color: Colors.white,
        ),
        child: Builder(builder: (context) {
          if (qrProvider == RequestState.loading ||
              studentProvider == RequestState.loading ||
              qrProvider.qrResult == null ||
              studentProvider.studentData == null) {
            return CustomShimmer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSize.verticalSpace[4],
                TextPlaceholder(),
                AppSize.verticalSpace[4],
                TextPlaceholder(),
                AppSize.verticalSpace[4],
                TextPlaceholder()
              ],
            ));
          }
          if (qrProvider == RequestState.error ||
              studentProvider == RequestState.error) {
            return EconError(errorMessage: '');
          }

          final qrResult = qrProvider.qrResult!;
          final studentData = studentProvider.studentData!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: AppSize.space[4],
                        left: AppSize.space[4],
                        right: AppSize.space[2],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSize.verticalSpace[2],
                          Text(
                            'Mata Kuliah',
                            style: kTextHeme.subtitle1?.copyWith(
                              color: Palette.disable,
                              height: 1,
                            ),
                          ),
                          Text(
                            qrResult
                                .meetingData.clazzData!.courseData!.courseName!,
                            style: kTextHeme.headline5
                                ?.copyWith(color: Palette.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppSize.space[2],
                      right: AppSize.space[0],
                    ),
                    child: IconButton(
                      onPressed: () {
                        qrProvider.resetQrCode();
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(
                  AppSize.space[4],
                ),
                child: Column(
                  children: [
                    _buildAbsentTile(
                      title: studentData.name!,
                      iconPath: 'assets/icons/user.svg',
                    ),
                    AppSize.verticalSpace[1],
                    _buildAbsentTile(
                      title:
                          '${qrResult.meetingData.clazzData!.startTime} - ${qrResult.meetingData.clazzData!.endTime}',
                      iconPath: 'assets/icons/time.svg',
                    ),
                    AppSize.verticalSpace[1],
                    _buildAbsentTile(
                      title: ReusableFuntionHelper.datetimeToString(
                          qrResult.meetingData.date!),
                      iconPath: 'assets/icons/date.svg',
                    ),
                    AppSize.verticalSpace[5],
                    CustomButton(
                      height: 50,
                      text: 'Konfirmasi',
                      onTap: () {
                        // #TODO hit api absen with valcode and meetingId

                        attendanceProvider.setAttendance(
                          meetingId: qrResult.meetingData.id,
                          studentId: studentData.id!,
                          attendanceTypeId: 0,
                          attendanceId: 0,
                        );
                        if (attendanceProvider.setAttendanceState ==
                            RequestState.success) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const SuccessAttendanceModal();
                            },
                          );
                        }
                      },
                    ),
                    AppSize.verticalSpace[5],
                  ],
                ),
              )
            ],
          );
        }),
      ),
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
            color: Palette.primaryVariant,
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
              color: Palette.primaryVariant,
            ),
          ),
        ),
      ],
    );
  }
}
