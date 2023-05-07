import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/absent/lecturer_absent_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/home/lecturer_home_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/notif_seminars/notif_seminar_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/pages/setting/lecturer_setting_page.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecture_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/providers/profile_picture_notifier.dart';
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
    LecturerHomePage(),
    LecturerNotifSeminarPage(),
    LecturerAbsentPage(),
    LecturerSettingPage(),
  ];

  final List<SalomonBottomBarItem> items = [
    SalomonBottomBarItem(
      icon: Icon(Icons.home_rounded),
      title: Text('Beranda'),
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.notifications),
      title: Text('Notifikasi'),
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
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: IndexedStack(children: listMenu, index: selectIndex),
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
