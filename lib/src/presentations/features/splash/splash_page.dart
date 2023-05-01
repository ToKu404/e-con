import 'dart:async';

import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/widgets/gradient_bg.dart';
import 'package:e_con/src/presentations/widgets/grid_painter.dart';
import 'package:e_con/src/presentations/widgets/logo_container.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    // Will change page after two second
    super.didChangeDependencies();
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.wrapper,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBg(
        child: Stack(
          children: [
            Container(
              width: AppSize.getAppWidth(context),
              height: AppSize.getAppHeight(context),
              child: CustomPaint(
                painter:
                    GridPainter(color: Palette.primaryVariant.withOpacity(.8)),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSize.space[6],
                  horizontal: AppSize.space[5],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const LogoContainer(
                          width: 100,
                          height: 100,
                        ),
                        AppSize.verticalSpace[4],
                        Text(
                          'E-Con',
                          style: kTextHeme.headline1?.copyWith(
                            height: 1,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: 280,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Bagian Dari',
                              style: kTextHeme.subtitle1?.copyWith(
                                  color: Palette.white.withOpacity(.8)),
                              children: [
                                TextSpan(
                                  text: ' Sistem Informasi \nFarmasi (SIFA)',
                                  style: kTextHeme.subtitle1?.copyWith(
                                      height: 1.2, color: Palette.white),
                                ),
                                TextSpan(
                                  text: ' Universitas Hasanuddin',
                                  style: kTextHeme.subtitle1?.copyWith(
                                      height: 1.2,
                                      color: Palette.white.withOpacity(.8)),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: AppSize.getAppWidth(context),
                        alignment: Alignment.center,
                        child: Text(
                          'Versi 1.3.10',
                          style: kTextHeme.subtitle1
                              ?.copyWith(color: Palette.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
