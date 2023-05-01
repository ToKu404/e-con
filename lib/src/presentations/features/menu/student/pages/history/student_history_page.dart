import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/history/provider/attendance_history_notifier.dart';
import 'package:e_con/src/presentations/features/menu/widgets/class_card.dart';
import 'package:e_con/src/presentations/reusable_pages/check_internet_onetime.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_empty.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/default_appbar.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentHistoryPage extends StatelessWidget {
  const StudentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Expanded(
              child: CheckInternetOnetime(child: (context) {
                return RefreshIndicator(
                  onRefresh: () async {
                    Provider.of<AttendanceHistoryNotifier>(context,
                            listen: false)
                        .fetchListStudentClasses();
                  },
                  child: CustomScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: ClampingScrollPhysics(),
                      ),
                      slivers: [
                        SliverToBoxAdapter(
                          child: _BodySection(),
                        ),
                      ]),
                );
              }),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          child: DefaultAppBar(
            title: 'Riwayat Kehadiran',
          ),
        )
      ],
    );
  }
}

class _BodySection extends StatefulWidget {
  const _BodySection();

  @override
  State<_BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<_BodySection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AttendanceHistoryNotifier>(context, listen: false)
          .fetchListStudentClasses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AttendanceHistoryNotifier>();

    if (provider.studentClassesState == RequestState.loading ||
        provider.listStudentClass == null) {
      return CustomShimmer(
          child: Column(
        children: [
          AppSize.verticalSpace[4],
          CardPlaceholder(
            height: 120,
            horizontalPadding: AppSize.space[4],
          ),
          AppSize.verticalSpace[4],
          CardPlaceholder(
            height: 120,
            horizontalPadding: AppSize.space[4],
          ),
          AppSize.verticalSpace[4],
          CardPlaceholder(
            height: 120,
            horizontalPadding: AppSize.space[4],
          ),
        ],
      ));
    }

    final listClazzData = provider.listStudentClass;

    if (listClazzData!.isEmpty) {
      return EconEmpty(emptyMessage: "Belum Ada Riwayat Kelas");
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: AppSize.space[4],
      ),
      itemCount: listClazzData.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ClassCard(
          clazzData: listClazzData[index],
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.listStudentClasses,
            arguments: listClazzData[index],
          ),
        );
      },
    );
  }
}
