import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/data/models/attendance/helpers/attendance_value.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/widgets/attendance_student_card.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/widgets/teacher_meet_card.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/meeting_course_notifier.dart';
import 'package:e_con/src/presentations/features/menu/providers/attendance_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:e_con/src/presentations/widgets/choice_absent_modal.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/dialog/show_confirmation.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TeacherMeetDetailPage extends StatefulWidget {
  final Map args;
  const TeacherMeetDetailPage({super.key, required this.args});

  @override
  State<TeacherMeetDetailPage> createState() => _TeacherMeetDetailPageState();
}

class _TeacherMeetDetailPageState extends State<TeacherMeetDetailPage> {
  late int meetingId;
  late int meetingNumber;
  late ClazzData classData;
  @override
  void initState() {
    super.initState();
    meetingId = widget.args['meetingId'];
    meetingNumber = widget.args['meetingNumber'];
    classData = widget.args['classData'];
    Future.microtask(() {
      Provider.of<AttendanceNotifier>(context, listen: false)
        ..fetchListAttendance(meetingId: meetingId);
      Provider.of<MeetingCourseNotifier>(context, listen: false)
        ..getMeetingData(meetingId: meetingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final meetingProvider = context.watch<MeetingCourseNotifier>();

    if (meetingProvider.state == RequestState.loading ||
        meetingProvider.meetingData == null) {
      return EconLoading(
        withScaffold: true,
      );
    }
    final meetingData = meetingProvider.meetingData!;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Palette.background,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Pertemuan ${meetingNumber}',
            style: kTextHeme.headline5?.copyWith(
              color: Palette.black,
            ),
          ),
          actions: [
            PopupMenuButton<Function>(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 8.0,
              ),
              onSelected: (val) {
                // Navigator.pop(context);
                val.call();
              },
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    value: () async {
                      Navigator.pushNamed(context, AppRoute.editMeeting,
                          arguments: {
                            'classData': classData,
                            'topic': meetingData.topics,
                            'date': meetingData.date,
                            'meetingId': meetingData.id,
                          });
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.edit,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text('Edit')
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: () async {
                      final deleteConfirmation = await showConfirmation(
                          context: ctx,
                          title: 'Yakin ingin menghapus pertemuan ini?');
                      if (deleteConfirmation) {
                        await meetingProvider.deleteMeeting(
                            meetingId: meetingData.id);
                        await meetingProvider.getListMeeting(
                            classId: classData.id!);
                        Navigator.pop(context);
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete_rounded,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text('Hapus')
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(
                      AppSize.space[3],
                    ),
                    color: Palette.background,
                    child: Container(
                      padding: EdgeInsets.all(AppSize.space[3]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSize.space[3],
                        ),
                        color: Colors.white,
                        border: Border.all(
                          color: Palette.field,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AbsentStatisticCard(
                                absentStatus: AttendanceValueHelper.getAttendanceValue(1),
                                value: 49,
                              ),
                              AppSize.horizontalSpace[2],
                              AbsentStatisticCard(
                                absentStatus: AttendanceValueHelper.getAttendanceValue(4),
                                value: 2,
                              ),
                            ],
                          ),
                          AppSize.verticalSpace[2],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AbsentStatisticCard(
                                absentStatus: AttendanceValueHelper.getAttendanceValue(3),
                                value: 3,
                              ),
                              AppSize.horizontalSpace[2],
                              AbsentStatisticCard(
                                absentStatus: AttendanceValueHelper.getAttendanceValue(2),
                                value: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _CustomAppBar(
                  meetingId: meetingId,
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSize.space[3],
                    horizontal: AppSize.space[3],
                  ),
                  sliver: Builder(builder: (context) {
                    final attendanceProvider =
                        context.watch<AttendanceNotifier>();
                    if (attendanceProvider.state == RequestState.loading) {
                      return SliverToBoxAdapter(
                        child: CustomShimmer(
                            child: Column(
                          children: [
                            AppSize.verticalSpace[4],
                            CardPlaceholder(
                              height: 60,
                              horizontalPadding: 0,
                            ),
                            AppSize.verticalSpace[4],
                            CardPlaceholder(
                              height: 60,
                              horizontalPadding: 0,
                            ),
                            AppSize.verticalSpace[4],
                            CardPlaceholder(
                              height: 60,
                              horizontalPadding: 0,
                            )
                          ],
                        )),
                      );
                    }
                    final listAttendance =
                        attendanceProvider.listAttendanceData;

                    if (listAttendance.isEmpty) {
                      return SliverToBoxAdapter(
                        child: SizedBox.shrink(),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: listAttendance.length, (context, index) {
                        return Column(
                          children: [
                            AttedanceStudentCard(
                              attendanceData: listAttendance[index],
                            ),
                            SizedBox(
                              height: (index == 9) ? 66 : 8,
                            )
                          ],
                        );
                      }),
                    );
                  }),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.white.withOpacity(.5),
                      Colors.white
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                width: AppSize.getAppWidth(context),
                padding: EdgeInsets.all(AppSize.space[3]),
                child: CustomButton(
                  height: 54,
                  icon: Icons.qr_code_2_rounded,
                  text: 'Barcode Absen',
                  onTap: () async {
                    if (meetingData.validationCodeExpiredDate != null &&
                        !ReusableFuntionHelper.isInitialExpiredDate(
                            meetingData.validationCodeExpiredDate!)) {
                      if (meetingData.validationCodeExpiredDate!
                          .isAfter(DateTime.now())) {
                        final provider = context.read<MeetingCourseNotifier>();
                        await provider.getValidationCode(
                            meetingId: meetingData.id);

                        if (provider.validationCode != null) {
                          Navigator.pushNamed(context, AppRoute.barcodeAbsent,
                              arguments: {
                                'meetingId': meetingData.id,
                                'classData': classData,
                                'validationCode': provider.validationCode,
                                'meetingNumber': meetingNumber,
                              });
                        }
                      }
                      return;
                    }
                    meetingData.setMeetingNumber = meetingNumber;
                    Navigator.pushNamed(context, AppRoute.genBarcode,
                        arguments: {
                          'meetingData': meetingData,
                          'classData': classData,
                          'isEdit': false,
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatefulWidget {
  final int meetingId;
  const _CustomAppBar({required this.meetingId});

  @override
  State<_CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<_CustomAppBar> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
      child: DecoratedBox(
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
            AppSize.verticalSpace[3],
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.space[3],
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  context.read<AttendanceNotifier>()
                    ..fetchListAttendance(
                        meetingId: widget.meetingId, query: value);
                },
                keyboardType: TextInputType.text,
                style: kTextHeme.subtitle1?.copyWith(
                  color: Palette.onPrimary,
                ),
                cursorColor: Palette.primary,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  hintText: 'Pencarian',
                  hintStyle:
                      kTextHeme.subtitle1?.copyWith(color: Palette.disable),
                  filled: true,
                  prefixIcon: const SizedBox(
                    height: 12,
                    width: 12,
                    child: Icon(
                      Icons.search,
                      color: Palette.disable,
                    ),
                  ),
                  prefixIconColor: Palette.disable,
                  fillColor: Palette.field,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Palette.field),
                    borderRadius: BorderRadius.circular(
                      AppSize.space[3],
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Palette.primary),
                    borderRadius: BorderRadius.circular(
                      AppSize.space[3],
                    ),
                  ),
                  // errorText: !state.isEmailValid
                  //     ? 'Please ensure the email entered is valid'
                  //     : null,
                  // labelText: 'Email',
                ),
              ),
            ),
            // AppSize.verticalSpace[3],
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       AppSize.horizontalSpace[3],
            //       const CustomChip(
            //         title: 'Nama',
            //         haveShowMore: true,
            //       ),
            //       const CustomChip(
            //         title: 'Hadir',
            //       ),
            //       const CustomChip(
            //         title: 'Izin',
            //       ),
            //       const CustomChip(
            //         title: 'Sakit',
            //       ),
            //     ],
            //   ),
            // ),
            AppSize.verticalSpace[5],
          ],
        ),
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  final String title;
  final bool haveShowMore;
  const CustomChip({
    super.key,
    required this.title,
    this.haveShowMore = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: AppSize.space[2]),
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.space[4],
        ),
        border: Border.all(
          color: Palette.disable,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.space[3],
        vertical: AppSize.space[1],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: kTextHeme.subtitle2?.copyWith(
              color: Palette.onPrimary,
            ),
          ),
          if (haveShowMore)
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: Palette.onPrimary,
            ),
        ],
      ),
    );
  }
}

class AbsentStatisticCard extends StatelessWidget {
  final int value;
  final AttendanceValue absentStatus;
  const AbsentStatisticCard({
    super.key,
    required this.value,
    required this.absentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSize.space[3],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.space[2],
          ),
          border: Border.all(
            color: absentStatus.color,
          ),
        ),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: kTextHeme.headline1?.copyWith(
                color: Palette.onPrimary,
                height: 1,
              ),
            ),
            AppSize.verticalSpace[0],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  absentStatus.iconPath,
                  height: 14,
                  width: 14,
                ),
                AppSize.horizontalSpace[1],
                Text(
                  absentStatus.status,
                  style: kTextHeme.subtitle1?.copyWith(
                    color: absentStatus.color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
