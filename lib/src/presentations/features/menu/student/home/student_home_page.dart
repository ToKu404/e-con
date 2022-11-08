import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/widgets/header_logo.dart';
import 'package:flutter/material.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 65,
          width: AppSize.getAppWidth(context),
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HeaderLogo(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.badge_rounded,
                  color: Palette.primary,
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          child: CustomScrollView(
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: AlwaysScrollableScrollPhysics(
              parent: ClampingScrollPhysics(),
            ),
            slivers: [
              NotifSection(),
              ActivitySection(),
            ],
          ),
        ),
      ],
    );
  }
}

class NotifSection extends StatelessWidget {
  const NotifSection({super.key});

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
                    style: kTextHeme.subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
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

class ActivitySection extends StatelessWidget {
  const ActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> selectIndex = ValueNotifier(0);
    final dayName = [
      'Sen',
      'Sel',
      'Rab',
      'Kam',
      'Jum',
    ];
    return SliverToBoxAdapter(
      child: ValueListenableBuilder(
          valueListenable: selectIndex,
          builder: (context, val, _) {
            return Column(
              children: [
                Container(
                  width: AppSize.getAppWidth(context),
                  decoration: const BoxDecoration(
                    color: Palette.primary,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.space[4],
                    vertical: AppSize.space[3],
                  ),
                  child: Text(
                    'Aktivitas',
                    style: kTextHeme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: AppSize.getAppWidth(context),
                  height: 40,
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
              ],
            );
          }),
    );
  }
}
