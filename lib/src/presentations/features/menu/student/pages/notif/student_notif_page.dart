import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/profile/notification.dart';
import 'package:e_con/src/presentations/features/menu/providers/user_notif_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/check_internet_onetime.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_empty.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/default_appbar.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentNotifPage extends StatelessWidget {
  const StudentNotifPage({super.key});

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
                    await Future.wait([
                      Provider.of<UserNotifNotifier>(context, listen: false)
                          .fetchNotifications(),
                    ]);
                  },
                  child: CustomScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: ClampingScrollPhysics(),
                    ),
                    slivers: [
                      SliverToBoxAdapter(child: _BodySection()),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
        DefaultAppBar(
          title: 'Notifikasi',
        ),
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
    Future.microtask(() =>
        Provider.of<UserNotifNotifier>(context, listen: false)
          ..fetchNotifications());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserNotifNotifier>();
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
    if (provider.listNotif.isEmpty) {
      return EconEmpty(emptyMessage: 'Belum ada notifikasi');
    }
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: provider.listNotif.length,
      itemBuilder: (context, index) {
        return _StudentNotifCard(
          notif: provider.listNotif[index],
        );
      },
    );
  }
}

class _StudentNotifCard extends StatelessWidget {
  final NotificationModel notif;
  const _StudentNotifCard({
    required this.notif,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.studentDetailFinalExam),
        child: Container(
          width: AppSize.getAppWidth(context),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Palette.background,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              AppSize.space[3],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SIFA',
                      overflow: TextOverflow.ellipsis,
                      style: kTextHeme.subtitle2?.copyWith(
                        color: Palette.primary,
                      ),
                    ),
                    if (notif.createdAt != null)
                      Text(
                        ReusableFunctionHelper.datetimeToString(
                            notif.createdAt!,
                            format: notif.createdAt!.day == DateTime.now().day
                                ? 'HH:mm dd MMM'
                                : 'dd MMM'),
                        style: kTextHeme.overline?.copyWith(
                          color: Palette.onPrimary,
                          height: 1,
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  notif.message ?? '',
                  style: kTextHeme.subtitle1?.copyWith(
                      color: Palette.onPrimary,
                      fontWeight: FontWeight.w500,
                      height: 1),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Update Tugas Akhir',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kTextHeme.subtitle2?.copyWith(
                    color: Palette.disable,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
