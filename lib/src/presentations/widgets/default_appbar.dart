import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? action;

  DefaultAppBar({required this.title, this.leading, this.action});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: AppSize.getAppWidth(context),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            offset: const Offset(1, 2),
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leading != null) leading!,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.space[4],
              ),
              child: Text(
                title,
                style: kTextHeme.headline5?.copyWith(
                  color: Palette.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          action != null
              ? action!
              : SizedBox(
                  height: 60,
                  width: 60,
                ),
        ],
      ),
    );
  }
}
