import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/widgets/logo_container.dart';
import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  final Color bgColor;
  const HeaderLogo({super.key, this.bgColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LogoContainer(
            width: 30,
            height: 30,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            'E-Con',
            style: kTextHeme.subtitle1?.copyWith(
              color: Palette.primaryVariant,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
