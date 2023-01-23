import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/blocs/onetime_internet_check/onetime_internet_check_cubit.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/notif_seminars/widgets/lecturer_seminar_card.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecturer_seminars_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_no_internet.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<OnetimeInternetCheckCubit>(context)
        .onCheckConnectionOnetime();
  }

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
              child: Builder(builder: (context) {
                return SingleChildScrollView(
                  child: Builder(builder: (context) {
                    final provider = context.watch<LecturerSeminarNotifier>();
                    return BlocBuilder<OnetimeInternetCheckCubit,
                        OnetimeInternetCheckState>(builder: (context, state) {
                      if (state is OnetimeInternetCheckLost) {
                        return EconNoInternet(
                          onReload: () {
                            BlocProvider.of<OnetimeInternetCheckCubit>(context)
                                .onCheckConnectionOnetime();
                          },
                        );
                      }
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
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Belum ada pemberitahuan seminar',
                            style: TextStyle(
                              color: Palette.disable,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
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
                );
              }),
            ),
          ],
        ),
        DefaultAppBar(
          title: 'Notifikasi Seminar',
        ),
      ],
    );
  }
}
