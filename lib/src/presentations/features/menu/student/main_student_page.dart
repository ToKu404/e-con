import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:e_con/core/constants/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainStudentPage extends StatefulWidget {
  const MainStudentPage({super.key});

  @override
  State<MainStudentPage> createState() => _MainStudentPageState();
}

class _MainStudentPageState extends State<MainStudentPage> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    final listMenu = [
      Container(
        child: Text('Menu1'),
      ),
      Container(
        child: Text('Menu2'),
      ),
      Container(
        child: Text('Menu3'),
      ),
      Container(
        child: Text('Menu4'),
      ),
      Container(
        child: Text('Menu5'),
      ),
    ];
    return Scaffold(
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
