import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/path_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoContainer extends StatelessWidget {
  final double width;
  final double height;
  final bool useShadow;
  const LogoContainer({
    super.key,
    required this.width,
    required this.height,
    this.useShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(width / 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
          color: Palette.background,
          boxShadow: useShadow
              ? [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(.25))
                ]
              : null),
      child: SvgPicture.asset(AssetPath.logoPath),
    );
  }
}
