import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/absent/teacher_absent_page.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/activity/teacher_activity_page.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/lecture_profile_notifier.dart';
import 'package:e_con/src/presentations/widgets/header_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherMainPage extends StatefulWidget {
  const TeacherMainPage({super.key});

  @override
  State<TeacherMainPage> createState() => _TeacherMainPageState();
}

class _TeacherMainPageState extends State<TeacherMainPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<LectureProfileNotifier>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                _AppBarSection(),
              ];
            },
            body: const TabBarView(
              children: [TeacherActivityPage(), TeacherAbsentPage()],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarSection extends StatefulWidget {
  @override
  State<_AppBarSection> createState() => _AppBarSectionState();
}

class _AppBarSectionState extends State<_AppBarSection> {
  TabBar get _tabBar {
    return TabBar(
      // indicatorColor: Palette.primary,
      indicator: const BoxDecoration(
        color: Palette.primary,
      ),

      tabs: [
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.access_time_sharp,
                size: 18,
              ),
              AppSize.horizontalSpace[1],
              Text(
                'Kegiatan',
                style: kTextHeme.subtitle2?.copyWith(color: Colors.white),
              )
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.assignment_outlined,
                size: 18,
              ),
              AppSize.horizontalSpace[1],
              Text(
                'Absensi',
                style: kTextHeme.subtitle2?.copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      title: const HeaderLogo(),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.cplWebview);
          },
          icon: const Icon(
            Icons.badge_rounded,
            color: Palette.primary,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.teacherProfile);
          },
          icon: const Icon(
            Icons.settings_outlined,
            color: Palette.primary,
          ),
        )
      ],
      bottom: PreferredSize(
        preferredSize: _tabBar.preferredSize,
        child: ColoredBox(
          color: Palette.background.withOpacity(.8),
          child: _tabBar,
        ),
      ),
    );
  }
}
