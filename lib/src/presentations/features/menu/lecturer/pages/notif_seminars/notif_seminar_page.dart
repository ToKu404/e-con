import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/notif_seminars/widgets/lecturer_seminar_card.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecturer_seminars_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/check_internet_onetime.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_empty.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/default_appbar.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LecturerNotifSeminarPage extends StatefulWidget {
  const LecturerNotifSeminarPage({super.key});

  @override
  State<LecturerNotifSeminarPage> createState() =>
      _LecturerNotifSeminarPageState();
}

class _LecturerNotifSeminarPageState extends State<LecturerNotifSeminarPage> {
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
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.wait([
                    context
                        .read<LecturerSeminarNotifier>()
                        .fetchInvitedSeminars(),
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
                      child: Builder(builder: (context) {
                        final provider =
                            context.watch<LecturerSeminarNotifier>();
                        return CheckInternetOnetime(child: (context) {
                          if (provider.state == RequestState.loading) {
                            return CustomShimmer(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  CardPlaceholder(
                                    height: 80,
                                  ),
                                  AppSize.verticalSpace[3],
                                  CardPlaceholder(
                                    height: 100,
                                  ),
                                  AppSize.verticalSpace[3],
                                  CardPlaceholder(
                                    height: 100,
                                  ),
                                  AppSize.verticalSpace[3],
                                  CardPlaceholder(
                                    height: 100,
                                  ),
                                  AppSize.verticalSpace[3],
                                  CardPlaceholder(
                                    height: 100,
                                  ),
                                  AppSize.verticalSpace[3],
                                ],
                              ),
                            );
                          }

                          if (provider.seminars.isEmpty) {
                            return EconEmpty(
                                emptyMessage: 'Belum ada pemberitahuan');
                          }
                          return ListView.builder(
                            padding: EdgeInsets.only(top: 12),
                            shrinkWrap: true,
                            itemCount: provider.seminars.length,
                            itemBuilder: (context, index) {
                              return LecturerSeminarCard(
                                seminarData: provider.seminars[index],
                              );
                            },
                          );
                        });
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        DefaultAppBar(
          title: 'Jadwal Seminar',
        ),
      ],
    );
  }
}
