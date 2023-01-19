import 'dart:async';

import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/widgets/gradient_bg.dart';
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
                    width: 180,
                    height: 180,
                  ),
                  AppSize.verticalSpace[4],
                  Text(
                    'E-Con',
                    style: kTextHeme.headline2?.copyWith(
                      height: 1,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Bagian Dari',
                      style:
                          kTextHeme.subtitle1?.copyWith(color: Palette.white),
                      children: [
                        TextSpan(
                          text: ' SIFA',
                          style: kTextHeme.subtitle1?.copyWith(
                              fontWeight: FontWeight.bold,
                              height: 1,
                              color: Palette.white),
                        ),
                      ],
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
                    'Versi 1.0.0',
                    style: kTextHeme.subtitle1?.copyWith(color: Palette.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
