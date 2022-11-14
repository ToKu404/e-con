import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/widgets/logo_container.dart';
import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  final Color bgColor;
  const HeaderLogo({super.key, this.bgColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const LogoContainer(
          width: 30,
          height: 30,
        ),
        AppSize.horizontalSpace[2],
        Text(
          'E-Con',
          style: kTextHeme.headline5?.copyWith(
            color: Palette.primaryVariant,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );

    // return Container(
    //   padding: const EdgeInsets.symmetric(
    //     horizontal: 8,
    //     vertical: 4,
    //   ),
    //   decoration: BoxDecoration(
    //     color: bgColor,
    //     borderRadius: BorderRadius.circular(
    //       8.0,
    //     ),
    //   ),
    //   child: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       const LogoContainer(
    //         width: 30,
    //         height: 30,
    //       ),
    //       const SizedBox(
    //         width: 4,
    //       ),
    //       Text(
    //         'E-Con',
    //         style: kTextHeme.subtitle1?.copyWith(
    //           color: Palette.primaryVariant,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
