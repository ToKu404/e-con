import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/teacher_absent_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/activity/teacher_activity_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/setting/teacher_setting_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecture_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/providers/profile_picture_notifier.dart';
import 'package:e_con/src/presentations/widgets/header_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class TopIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TopIndicatorBox();
  }
}

class _TopIndicatorBox extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Paint _paint = Paint()
      ..color = Palette.primary
      ..strokeWidth = 3
      ..isAntiAlias = true;

    canvas.drawLine(offset, Offset(cfg.size!.width + offset.dx, 0), _paint);
  }
}

class TeacherMainPage extends StatefulWidget {
  const TeacherMainPage({super.key});

  @override
  State<TeacherMainPage> createState() => _TeacherMainPageState();
}

class _TeacherMainPageState extends State<TeacherMainPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    Future.microtask(() {
      Provider.of<LectureProfileNotifier>(context, listen: false)
        ..getStudentData();
      Provider.of<ProfilePictureNotifier>(context, listen: false)
        ..getProfilePicture();
    });
  }

  final listMenu = [
    TeacherActivityPage(),
    TeacherAbsentPage(),
    TeacherSettingPage()
  ];

  final List<SalomonBottomBarItem> items = [
    SalomonBottomBarItem(
      icon: Icon(Icons.home_rounded),
      title: Text('Beranda'),
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.assignment),
      title: Text('Kelas'),
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.account_box_rounded),
      title: Text('Pengguna'),
    ),
  ];
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: listMenu[selectIndex],
      ),
      bottomNavigationBar: Container(
        color: Palette.white,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SalomonBottomBar(
            items: items,
            unselectedItemColor: Palette.disable,
            currentIndex: selectIndex,
            onTap: (i) => setState(() => selectIndex = i)),
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
          color: Palette.disable.withOpacity(.5),
          child: _tabBar,
        ),
      ),
    );
  }
}
