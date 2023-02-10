import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/final_exam/fe_student.dart';
import 'package:e_con/src/data/models/final_exam/final_exam_data.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/home/widgets/lecturer_task_card.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/home/widgets/lecturer_today_seminar_card.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/notif_seminars/widgets/lecturer_seminar_card.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecturer_seminars_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecturer_today_meeting_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/check_internet_onetime.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/default_appbar.dart';
import 'package:e_con/src/presentations/widgets/header_logo.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LecturerHomePage extends StatefulWidget {
  const LecturerHomePage({super.key});

  @override
  State<LecturerHomePage> createState() => _LecturerHomePageState();
}

class _LecturerHomePageState extends State<LecturerHomePage> {
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
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pengingat Harian',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Palette.black,
                                height: 1.2,
                              ),
                            ),
                            Text(
                              ReusableFunctionHelper.datetimeToString(
                                  DateTime.now()),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Palette.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        color: Palette.disable,
                      ),
                      Builder(builder: (context) {
                        final provider =
                            context.watch<LecturerTodayMeetingNotifier>();
                        final seminarNotifier =
                            context.watch<LecturerSeminarNotifier>();

                        if (provider.state == RequestState.loading ||
                            provider.listMeetingData == null) {
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

                        final getTodaySeminar =
                            ReusableFunctionHelper.getTodayListSeminar(
                                seminarNotifier.seminars);

                        if (provider.listMeetingData!.isEmpty &&
                            getTodaySeminar.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Belum ada aktivitas yang dijadwalkan hari ini',
                              style: TextStyle(
                                color: Palette.disable,
                              ),
                            ),
                          );
                        }

                        if (getTodaySeminar.isNotEmpty)
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 12),
                            shrinkWrap: true,
                            itemCount: getTodaySeminar.length,
                            itemBuilder: (context, index) {
                              return TeacherTodaySeminarCard(
                                seminarData: getTodaySeminar[index],
                              );
                            },
                          );

                        if (provider.listMeetingData!.isNotEmpty)
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 12),
                            shrinkWrap: true,
                            itemCount: provider.listMeetingData?.length,
                            itemBuilder: (context, index) {
                              return TeacherTaskCard(
                                meetingData: provider.listMeetingData![index],
                              );
                            },
                          );

                        return SizedBox.shrink();
                      }),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
        DefaultAppBar(
          title: '',
          action: Padding(
            padding: EdgeInsets.only(right: AppSize.space[2]),
            child: ElevatedButton.icon(
              label: Text(
                'Buka SIFA',
                style: kTextHeme.subtitle1?.copyWith(color: Palette.white),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Palette.primaryVariant,
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.cplWebview);
              },
              icon: const Icon(
                Icons.open_in_new,
                size: 16,
                color: Palette.white,
              ),
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: AppSize.space[2]),
            child: HeaderLogo(),
          ),
        )
      ],
    );
  }
}
