import 'package:e_con/core/constants/size_const.dart';
import 'package:flutter/material.dart';

class CardPlaceholder extends StatelessWidget {
  final double height;
  final double horizontalPadding;
  CardPlaceholder({super.key, this.height = 150, this.horizontalPadding = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.getAppWidth(context),
      height: height,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppSize.space[3],
        ),
      ),
    );
  }
}
