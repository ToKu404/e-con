import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/final_exam_helper.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/final_exam/fe_exam.dart';
import 'package:e_con/src/data/models/final_exam/fe_proposed_thesis.dart';
import 'package:e_con/src/data/models/final_exam/fe_seminar.dart';
import 'package:e_con/src/presentations/features/login/provider/get_user_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/home/widgets/student_task_card.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_activity_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_final_exam_helper_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_final_exam_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/check_internet_onetime.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_empty.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/header_logo.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final ValueNotifier<WeeklyActivity> selectWeekly =
      ValueNotifier(ReusableFunctionHelper.getTodayActivityData());
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          Provider.of<StudentFinalExamNotifier>(context, listen: false)
            ..getProposedThesis(),
          Provider.of<StudentFinalExamNotifier>(context, listen: false)
            ..getSeminars(),
          Provider.of<StudentFinalExamNotifier>(context, listen: false)
            ..getThesisTrialExam(),
          context.read<GetUserNotifier>()..getCredential(),
        });
  }

  @override
  Widget build(BuildContext context) {
    final userNotifer = context.watch<GetUserNotifier>();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black38,
        title: const HeaderLogo(),
        actions: [
          if (userNotifer.credential.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                label: Text(
                  'Buka SIFA',
                  style: kTextHeme.subtitle1?.copyWith(color: Palette.white),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Palette.primaryVariant.withOpacity(.7),
                ),
                onPressed: () async {
                  final data = userNotifer.credential;
                  Navigator.pushNamed(context, AppRoutes.cplWebview,
                      arguments: {
                        'credential': data,
                      });
                },
                icon: const Icon(
                  Icons.open_in_new,
                  size: 16,
                  color: Palette.white,
                ),
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            Provider.of<StudentActivityNotifier>(context, listen: false)
                .fetchAllMeetingByDate(date: selectWeekly.value.date),
            Provider.of<StudentFinalExamNotifier>(context, listen: false)
                .getProposedThesis(),
            Provider.of<StudentFinalExamNotifier>(context, listen: false)
                .getSeminars(),
            Provider.of<StudentFinalExamNotifier>(context, listen: false)
                .getThesisTrialExam(),
          ]);
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: CheckInternetOnetime(child: (context) {
                return CustomScrollView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Builder(
                        builder: (context) {
                          final feProvider =
                              context.watch<StudentFinalExamNotifier>();

                          if (feProvider.proposedThesisState ==
                                  RequestState.loading ||
                              feProvider.seminarsState ==
                                  RequestState.loading ||
                              feProvider.trialExamState ==
                                  RequestState.loading ||
                              feProvider.listProposedThesis.isEmpty) {
                            return CustomShimmer(
                                child: Column(
                              children: [
                                AppSize.verticalSpace[6],
                                AppSize.verticalSpace[6],
                                CardPlaceholder(
                                  height: 100,
                                ),
                                AppSize.verticalSpace[4],
                              ],
                            ));
                          }
                          return _FinalExamSection(
                            proposedThesis: feProvider.listProposedThesis,
                            seminars: feProvider.listSeminar,
                            thesisTrialExam: feProvider.thesisTrialExam,
                          );
                        },
                      ),
                    ),
                    _ActivitySection(
                      selectWeekly: selectWeekly,
                    ),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class _ActivitySection extends StatelessWidget {
  final ValueNotifier<WeeklyActivity> selectWeekly;
  const _ActivitySection({required this.selectWeekly});

  @override
  Widget build(BuildContext context) {
    final listWeekly = ReusableFunctionHelper.getWeeklyActivityData();

    final ValueNotifier<bool?> isRightSwap = ValueNotifier(null);

    return ValueListenableBuilder(
      valueListenable: selectWeekly,
      builder: (context, val, _) {
        return MultiSliver(
          children: [
            SliverAppBar(
              pinned: true,
              toolbarHeight: 45,
              backgroundColor: Palette.primary,
              title: Text(
                'Aktivitas',
                style: kTextHeme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Palette.white,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: Container(
                  height: 40,
                  width: AppSize.getAppWidth(context),
                  decoration: const BoxDecoration(
                    color: Palette.primaryVariant,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.space[3],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listWeekly.map((e) {
                        return Expanded(
                          child: InkWell(
                            onTap: () {
                              selectWeekly.value = e;
                              Provider.of<StudentActivityNotifier>(context,
                                  listen: false)
                                ..fetchAllMeetingByDate(date: e.date);
                            },
                            child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color: val == e ? Palette.primary : null,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(
                                    AppSize.space[4],
                                  ),
                                  bottomRight: Radius.circular(
                                    AppSize.space[4],
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  e.dateName,
                                  style: kTextHeme.subtitle2,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: AppSize.space[2]),
            ),
            SliverFillRemaining(
              child: ValueListenableBuilder(
                  valueListenable: isRightSwap,
                  builder: (context, isRight, _) {
                    return GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        int sensitivity = 12;
                        if (details.delta.dx > sensitivity && val != 0) {
                          isRightSwap.value = true;
                        } else if (details.delta.dx < -sensitivity &&
                            val != 6) {
                          isRightSwap.value = false;
                        }
                      },
                      onHorizontalDragEnd: (details) {
                        if (isRight != null) {
                          selectWeekly.value = isRight
                              ? listWeekly[listWeekly.indexOf(val) - 1]
                              : listWeekly[listWeekly.indexOf(val) + 1];
                          isRightSwap.value = null;
                          Provider.of<StudentActivityNotifier>(context,
                              listen: false)
                            ..fetchAllMeetingByDate(
                                date: selectWeekly.value.date);
                        }
                      },
                      child: ActivityBody(
                        date: val.date,
                      ),
                    );
                  }),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: AppSize.space[4]),
            ),
          ],
        );
      },
    );
  }
}

class _FinalExamSection extends StatefulWidget {
  final List<FeProposedThesis> proposedThesis;
  final List<FeSeminar> seminars;
  final FeExam? thesisTrialExam;

  _FinalExamSection(
      {required this.proposedThesis,
      required this.seminars,
      required this.thesisTrialExam});

  @override
  State<_FinalExamSection> createState() => _FinalExamSectionState();
}

class _FinalExamSectionState extends State<_FinalExamSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<StudentFinalExamHelperNotifier>(context, listen: false)
          ..init(
              context: context,
              listProposedThesis: widget.proposedThesis,
              listTrialExam: widget.thesisTrialExam,
              listSeminar: widget.seminars));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentFinalExamHelperNotifier>();
    if (provider.homeFinalExamDta.isEmpty) {
      return SizedBox();
    }
    if (provider.state == RequestState.loading) {
      return CustomShimmer(
          child: Column(
        children: [
          AppSize.verticalSpace[4],
          CardPlaceholder(
            height: 100,
          ),
          AppSize.verticalSpace[4],
        ],
      ));
    }
    final listFeObject = provider.homeFinalExamDta;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSize.space[4]),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.space[4]),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Informasi ',
                    style: kTextHeme.subtitle1?.copyWith(
                      color: Palette.onPrimary,
                    ),
                    children: [
                      TextSpan(
                        text: 'Tugas Akhir',
                        style: kTextHeme.subtitle1?.copyWith(
                          color: Palette.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppSize.verticalSpace[3],
          if (listFeObject.length > 1)
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSize.space[4]),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: listFeObject
                    .map(
                      (data) => HomeFinalExamCard(proposedThesis: data),
                    )
                    .toList(),
              ),
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.space[4]),
              child: HomeFinalExamCard(proposedThesis: listFeObject.first),
            ),
        ],
      ),
    );
  }
}

class HomeFinalExamCard extends StatelessWidget {
  const HomeFinalExamCard({
    super.key,
    required this.proposedThesis,
  });

  final FinalExamObject proposedThesis;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8, right: 8),
      decoration: BoxDecoration(
        color: Palette.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Palette.onPrimary.withOpacity(
              .34,
            ),
          ),
          BoxShadow(
            blurRadius: 3.19,
            color: Palette.onPrimary.withOpacity(
              .20,
            ),
          ),
          BoxShadow(
            blurRadius: 1,
            color: Palette.onPrimary.withOpacity(
              .13,
            ),
          ),
        ],
        borderRadius: BorderRadius.circular(
          AppSize.space[3],
        ),
      ),
      child: InkWell(
        onTap: proposedThesis.onclick,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 7,
              width: AppSize.getAppWidth(context) - (AppSize.space[4] * 2),
              decoration: BoxDecoration(
                  color: Palette.primary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSize.space[3]),
                      topRight: Radius.circular(AppSize.space[3]))),
            ),
            Padding(
              padding: EdgeInsets.all(
                AppSize.space[3],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    proposedThesis.title,
                    style: kTextHeme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Palette.onPrimary,
                    ),
                  ),
                  Text(
                    proposedThesis.subtitle ?? '',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style:
                        kTextHeme.subtitle2?.copyWith(color: Palette.onPrimary),
                  ),
                  AppSize.verticalSpace[4],
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: proposedThesis.color,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      proposedThesis.status,
                      style: kTextHeme.subtitle2?.copyWith(height: 1.2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityBody extends StatefulWidget {
  final DateTime date;
  const ActivityBody({super.key, required this.date});

  @override
  State<ActivityBody> createState() => _ActivityBodyState();
}

class _ActivityBodyState extends State<ActivityBody> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<StudentActivityNotifier>(context, listen: false)
        ..fetchAllMeetingByDate(date: widget.date);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentActivityNotifier>();
    if (provider.state == RequestState.loading) {
      return SingleChildScrollView(
        child: CustomShimmer(
            child: Column(
          children: [
            AppSize.verticalSpace[3],
            CardPlaceholder(
              height: 70,
              horizontalPadding: AppSize.space[4],
            ),
            AppSize.verticalSpace[3],
            CardPlaceholder(
              height: 70,
              horizontalPadding: AppSize.space[4],
            ),
            AppSize.verticalSpace[3],
            CardPlaceholder(
              height: 70,
              horizontalPadding: AppSize.space[4],
            ),
            AppSize.verticalSpace[3],
            CardPlaceholder(
              height: 70,
              horizontalPadding: AppSize.space[4],
            ),
            AppSize.verticalSpace[3],
          ],
        )),
      );
    }

    final listMeeting = provider.listMeetingData;

    if (listMeeting.isEmpty) {
      return EconEmpty(emptyMessage: 'Belum ada kegiatan untuk hari ini');
    }

    return Builder(builder: (context) {
      return ListView.builder(
        itemCount: listMeeting.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return StudentTaskCard(
            meetingData: listMeeting[index],
          );
        },
      );
    });
  }
}
