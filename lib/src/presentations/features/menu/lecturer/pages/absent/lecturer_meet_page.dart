import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/attendance/helpers/attendance_value.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/presentations/features/menu/bloc/cubit/attendance_cubit.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/widgets/attendance_student_card.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/meeting_course_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/check_internet_onetime.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/dialog/show_confirmation.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class LecturerMeetDetailPage extends StatefulWidget {
  final Map args;
  const LecturerMeetDetailPage({super.key, required this.args});

  @override
  State<LecturerMeetDetailPage> createState() => _LecturerMeetDetailPageState();
}

class _LecturerMeetDetailPageState extends State<LecturerMeetDetailPage> {
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
      // Provider.of<AttendanceNotifier>(context, listen: false)
      //   ..fetchListAttendance(meetingId: meetingId);
      BlocProvider.of<AttendanceCubit>(context, listen: false)
        ..onFetchAttendance(meetingId: meetingId);
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
    return WillPopScope(
      onWillPop: () async {
        // final prov = context.read<MeetingCourseNotifier>();
        // await prov.getListMeeting(classId: classData.id!);
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Palette.background,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () async {
                // final prov = context.read<MeetingCourseNotifier>();
                // await prov.getListMeeting(classId: classData.id!);
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
                        Navigator.pushNamed(context, AppRoutes.editMeeting,
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
          body: CheckInternetOnetime(child: (context) {
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    await Future.wait([
                      BlocProvider.of<AttendanceCubit>(context, listen: false)
                          .onFetchAttendance(meetingId: meetingId),
                      Provider.of<MeetingCourseNotifier>(context, listen: false)
                          .getMeetingData(meetingId: meetingId),
                    ]);
                  },
                  child: CustomScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: ClampingScrollPhysics(),
                    ),
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
                            child: _StatisticSection(
                              meetingId: meetingId,
                            ),
                          ),
                        ),
                      ),
                      _CustomAppBar(
                        meetingId: meetingId,
                      ),
                      SliverPadding(
                        padding: EdgeInsets.all(
                          AppSize.space[4],
                        ),
                        sliver: BlocBuilder<AttendanceCubit, AttendanceState>(
                          builder: (context, state) {
                            if (state is AttendanceLoading ||
                                state is AttendanceInitial) {
                              return SliverToBoxAdapter(
                                child: CustomShimmer(
                                    child: Column(
                                  children: [
                                    CardPlaceholder(
                                      height: 80,
                                      horizontalPadding: 0,
                                    ),
                                    AppSize.verticalSpace[4],
                                    CardPlaceholder(
                                      height: 80,
                                      horizontalPadding: 0,
                                    ),
                                    AppSize.verticalSpace[4],
                                    CardPlaceholder(
                                      height: 80,
                                      horizontalPadding: 0,
                                    )
                                  ],
                                )),
                              );
                            }
                            if (state is FetchAttendanceSuccess) {
                              final listAttendance = state.attendanceData;

                              if (listAttendance.isEmpty) {
                                return SliverToBoxAdapter(
                                  child: SizedBox.shrink(),
                                );
                              }

                              return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    childCount: listAttendance.length,
                                    (context, index) {
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
                            }

                            if (state is FetchAttendanceFailure) {
                              return EconError(errorMessage: state.message);
                            }
                            return SliverToBoxAdapter(
                              child: SizedBox.shrink(),
                            );
                          },
                        ),
                      )
                      // SliverPadding(
                      //   padding: EdgeInsets.all(AppSize.space[4]),
                      //   sliver: Builder(builder: (context) {
                      //     final attendanceProvider =
                      //         context.watch<AttendanceNotifier>();
                      //     if (attendanceProvider.state == RequestState.loading) {
                      //       return SliverToBoxAdapter(
                      //         child: CustomShimmer(
                      //             child: Column(
                      //           children: [
                      //             CardPlaceholder(
                      //               height: 80,
                      //               horizontalPadding: 0,
                      //             ),
                      //             AppSize.verticalSpace[4],
                      //             CardPlaceholder(
                      //               height: 80,
                      //               horizontalPadding: 0,
                      //             ),
                      //             AppSize.verticalSpace[4],
                      //             CardPlaceholder(
                      //               height: 80,
                      //               horizontalPadding: 0,
                      //             )
                      //           ],
                      //         )),
                      //       );
                      //     }
                      //     final listAttendance =
                      //         attendanceProvider.listAttendanceData;

                      //     if (listAttendance.isEmpty) {
                      //       return SliverToBoxAdapter(
                      //         child: SizedBox.shrink(),
                      //       );
                      //     }

                      //     return SliverList(
                      //       delegate: SliverChildBuilderDelegate(
                      //           childCount: listAttendance.length,
                      //           (context, index) {
                      //         return Column(
                      //           children: [
                      //             AttedanceStudentCard(
                      //               attendanceData: listAttendance[index],
                      //             ),
                      //             SizedBox(
                      //               height: (index == 9) ? 66 : 8,
                      //             )
                      //           ],
                      //         );
                      //       }),
                      //     );
                      //   }),
                      // ),
                    ],
                  ),
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
                            !ReusableFunctionHelper.isInitialExpiredDate(
                                meetingData.validationCodeExpiredDate!)) {
                          if (meetingData.validationCodeExpiredDate!
                              .isAfter(DateTime.now())) {
                            final provider =
                                context.read<MeetingCourseNotifier>();
                            await provider.getValidationCode(
                                meetingId: meetingData.id);

                            if (provider.validationCode != null) {
                              Navigator.pushNamed(
                                  context, AppRoutes.barcodeAbsent,
                                  arguments: {
                                    'meetingId': meetingData.id,
                                    'classData': classData,
                                    'validationCode': provider.validationCode,
                                    'meetingNumber': meetingNumber,
                                  });
                            }
                            return;
                          }
                        }

                        meetingData.setMeetingNumber = meetingNumber;
                        Navigator.pushNamed(context, AppRoutes.genBarcode,
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
            );
          }),
        ),
      ),
    );
  }
}

class _StatisticSection extends StatefulWidget {
  final int meetingId;
  const _StatisticSection({
    required this.meetingId,
  });

  @override
  State<_StatisticSection> createState() => _StatisticSectionState();
}

class _StatisticSectionState extends State<_StatisticSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MeetingCourseNotifier>(context, listen: false)
        ..getListAttendanceStatistic(meetingId: widget.meetingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final statProvider = context.watch<MeetingCourseNotifier>();
    if (statProvider.listStatisticState == RequestState.loading ||
        statProvider.listStatisticData == null) {
      return CustomShimmer(
          child: CardPlaceholder(
        height: 160,
        horizontalPadding: 0,
      ));
    } else if (statProvider.listStatisticState == RequestState.error) {
      return SizedBox.shrink();
    }
    final statData = statProvider.listStatisticData!;
    final getStatValue = ReusableFunctionHelper.getStatisticValue(statData);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AbsentStatisticCard(
              absentStatus: AttendanceValueHelper.getAttendanceValue(1),
              value: getStatValue[1]!,
            ),
            AppSize.horizontalSpace[2],
            AbsentStatisticCard(
              absentStatus: AttendanceValueHelper.getAttendanceValue(4),
              value: getStatValue[4]!,
            ),
          ],
        ),
        AppSize.verticalSpace[2],
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AbsentStatisticCard(
              absentStatus: AttendanceValueHelper.getAttendanceValue(3),
              value: getStatValue[3]!,
            ),
            AppSize.horizontalSpace[2],
            AbsentStatisticCard(
              absentStatus: AttendanceValueHelper.getAttendanceValue(2),
              value: getStatValue[2]!,
            ),
          ],
        ),
      ],
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
                  BlocProvider.of<AttendanceCubit>(context, listen: false)
                    ..onFetchAttendance(
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
                ),
              ),
            ),
            AppSize.verticalSpace[5],
          ],
        ),
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
                    fontWeight: FontWeight.normal,
                    color: Palette.black,
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
