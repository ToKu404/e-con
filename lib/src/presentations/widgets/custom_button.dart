import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  double? height;
  String? iconPath;
  IconData? icon;
  Color? color;
  Color? textColor;
  CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height,
    this.iconPath,
    this.icon,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height ?? 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12,
          ),
          color: color ?? Palette.primary,
          border: Border.all(
            color: textColor ?? Colors.white,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Palette.onPrimary.withOpacity(
                .34,
              ),
            ),
            BoxShadow(
              blurRadius: 3.19,
              color: Palette.onPrimary.withOpacity(
                .20,
              ),
            ),
            BoxShadow(
              blurRadius: 1,
              color: Palette.onPrimary.withOpacity(
                .13,
              ),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconPath != null)
                SvgPicture.asset(
                  iconPath ?? '',
                  width: 20,
                  height: 20,
                  color: textColor ?? Colors.white,
                ),
              if (icon != null)
                Icon(
                  icon,
                  color: textColor ?? Colors.white,
                ),
              if (iconPath != null || icon != null) AppSize.horizontalSpace[2],
              Text(
                text,
                style: kTextHeme.subtitle1?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor ?? Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
