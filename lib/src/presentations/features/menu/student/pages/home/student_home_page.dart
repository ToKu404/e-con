import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/home/widgets/student_task_card.dart';
import 'package:e_con/src/presentations/widgets/header_logo.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        _AppBarSection(),
        _NotifSection(),
        _ActivitySection(),
      ],
    );
  }
}

class _AppBarSection extends StatelessWidget {
  const _AppBarSection();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: const HeaderLogo(),
      actions: [
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
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.cplWebview);
            },
            icon: const Icon(
              Icons.open_in_new,
              size: 16,
              color: Palette.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActivitySection extends StatelessWidget {
  const _ActivitySection();

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> selectIndex = ValueNotifier(0);
    final ValueNotifier<bool?> isRightSwap = ValueNotifier(null);

    final dayName = [
      'Sen',
      'Sel',
      'Rab',
      'Kam',
      'Jum',
      'Sab',
      'Min',
    ];
    return ValueListenableBuilder(
      valueListenable: selectIndex,
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
                      children: dayName.map((e) {
                        return Expanded(
                          child: InkWell(
                            onTap: () {
                              selectIndex.value = dayName.indexOf(e);
                            },
                            child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color: val == dayName.indexOf(e)
                                    ? Palette.primary
                                    : null,
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
                                  e,
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
            SliverToBoxAdapter(
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
                            selectIndex.value = isRight ? val - 1 : val + 1;
                            isRightSwap.value = null;
                          }
                        },
                        child: const ActivityBody());
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

class _NotifSection extends StatelessWidget {
  const _NotifSection();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(AppSize.space[4]),
        child: Column(
          children: [
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Pengingat ',
                    style: kTextHeme.subtitle1?.copyWith(
                      color: Palette.onPrimary,
                    ),
                    children: [
                      TextSpan(
                        text: 'Harian',
                        style: kTextHeme.subtitle1?.copyWith(
                          color: Palette.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: AppSize.space[1]),
                  padding: EdgeInsets.all(AppSize.space[1]),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.primaryVariant,
                  ),
                  child: Center(
                    child: Text(
                      '2',
                      style: kTextHeme.overline,
                    ),
                  ),
                ),
              ],
            ),
            AppSize.verticalSpace[3],
            Container(
              padding: EdgeInsets.all(
                AppSize.space[3],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppSize.space[3],
                ),
                color: Palette.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jadwal Seminar Proposal',
                    style: kTextHeme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Palette.white,
                    ),
                  ),
                  AppSize.verticalSpace[1],
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Egestas proin quis mollis libero viverra auctor. Viverra curabitur nunc lorem euismod odio sapien. Varius iaculis faucibus lorem elit sapien eget blandit purus. Morbi scelerisque consectetur leo mi diam pretium et. Id sit fusce ultrices varius dui. Est non quis nisi morbi ac. Vivamus consequat lobortis arcu volutpat. ',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: kTextHeme.subtitle2?.copyWith(height: 1.2),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityBody extends StatelessWidget {
  const ActivityBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const StudentTaskCard();
      },
    );
  }
}
