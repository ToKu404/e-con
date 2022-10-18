import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/widgets/gradient_bg.dart';
import 'package:e_con/widgets/logo_container.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBg(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LogoContainer(
              width: 200,
              height: 200,
              useShadow: true,
            ),
            AppSize.verticalSpace[3],
            const Text('E-Con'),
            AppSize.verticalSpace[1],
            RichText(
              text: const TextSpan(
                text: 'Bagian Dari',
                children: [
                  TextSpan(text: ' SIFA'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
