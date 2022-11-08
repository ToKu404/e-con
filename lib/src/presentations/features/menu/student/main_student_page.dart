import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/src/presentations/features/menu/student/home/student_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainStudentPage extends StatefulWidget {
  const MainStudentPage({super.key});

  @override
  State<MainStudentPage> createState() => _MainStudentPageState();
}

class _MainStudentPageState extends State<MainStudentPage> {
  int selectIndex = 0;
  final listMenu = [
    const StudentHomePage(),
    Container(
      child: const Text('Menu2'),
    ),
    Container(
      child: const Text('Menu3'),
    ),
    Container(
      child: const Text('Menu4'),
    ),
    Container(
      child: const Text('Menu5'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: listMenu[selectIndex],
      ),
      bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.white,
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
          onTap: (int i) {
            setState(() {
              selectIndex = i;
            });
          }),
    );
  }
}
