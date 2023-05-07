import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/path_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/src/presentations/features/menu/providers/profile_picture_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/history/student_history_page.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/home/student_home_page.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/notif/student_notif_page.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/setting/student_setting_page.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

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
    SizedBox.shrink(),
    const StudentHistoryPage(),
    const StudentSettingPage()
  ];

  @override
  void initState() {
    Future.microtask(() {
      Provider.of<StudentProfileNotifier>(context, listen: false)
        ..getStudentData();
      Provider.of<ProfilePictureNotifier>(context, listen: false)
        ..getProfilePicture();
    });
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body:
          SafeArea(child: IndexedStack(children: listMenu, index: selectIndex)),
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
                AssetPath.iconHome,
                color: Palette.disable,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                AssetPath.iconHomeActive,
                color: Palette.primaryVariant,
              ),
            ),
          ),
          TabItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                AssetPath.iconNotif,
                color: Palette.disable,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                AssetPath.iconNotifActive,
                color: Palette.primaryVariant,
              ),
            ),
          ),
          TabItem(
            icon: CircleAvatar(
              backgroundColor: Palette.primary,
              child: Center(
                child: SvgPicture.asset(
                  AssetPath.iconQr,
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
                AssetPath.iconHistory,
                color: Palette.disable,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                AssetPath.iconHistoryActive,
                color: Palette.primaryVariant,
              ),
            ),
          ),
          TabItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                AssetPath.iconProfile,
                color: Palette.disable,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                AssetPath.iconProfileActive,
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
                AppRoutes.absentStudent,
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
