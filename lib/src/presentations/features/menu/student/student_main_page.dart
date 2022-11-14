import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/src/presentations/features/menu/student/history/student_history_page.dart';
import 'package:e_con/src/presentations/features/menu/student/home/student_home_page.dart';
import 'package:e_con/src/presentations/features/menu/student/notif/student_notif_page.dart';
import 'package:e_con/src/presentations/features/menu/student/setting/student_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

class StudentMainPage extends StatefulWidget {
  const StudentMainPage({super.key});

  @override
  State<StudentMainPage> createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage>
    with TickerProviderStateMixin {
  int selectIndex = 0;
  TabController? tabController;
  final listMenu = [
    const StudentHomePage(),
    const StudentNotifPage(),
    null,
    const StudentHistoryPage(),
    const StudentSettingPage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: listMenu[selectIndex] != null
            ? listMenu[selectIndex]!
            : const SizedBox.shrink(),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.white,
        controller: tabController,
        curveSize: 100,
        elevation: 0,
        height: 50,
        style: TabStyle.fixedCircle,
        items: [
          TabItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/icons/home_outlined_icon.svg',
                color: Palette.disable,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/icons/home_fill_icon.svg',
                color: Palette.primaryVariant,
              ),
            ),
          ),
          TabItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/icons/notif_outlined_icon.svg',
                color: Palette.disable,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/icons/notif_fill_icon.svg',
                color: Palette.primaryVariant,
              ),
            ),
          ),
          TabItem(
            icon: CircleAvatar(
              backgroundColor: Palette.primary,
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/qr.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
          TabItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/icons/history_outlined_icon.svg',
                color: Palette.disable,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/icons/history_fill_icon.svg',
                color: Palette.primaryVariant,
              ),
            ),
          ),
          TabItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/icons/setting_outlined_icon.svg',
                color: Palette.disable,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/icons/setting_fill_icon.svg',
                color: Palette.primaryVariant,
              ),
            ),
          ),
        ],
        onTap: (int i) async {
          if (i == 2) {
            final status = await _getCameraPermission();
            if (!mounted) return;
            if (status.isGranted) {
              Navigator.pushNamed(
                context,
                AppRoute.absentStudent,
              );
            }
            tabController!.index = 0;

            i = 0;
          }
          setState(() {
            selectIndex = i;
          });
        },
      ),
    );
  }

  Future<PermissionStatus> _getCameraPermission() async {
    final status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return result;
    } else {
      return status;
    }
  }
}
