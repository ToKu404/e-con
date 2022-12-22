import 'package:e_con/core/constants/size_const.dart';
import 'package:flutter/material.dart';

class CardPlaceholder extends StatelessWidget {
  const CardPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.getAppWidth(context),
      height: 150,
      margin: EdgeInsets.only(
        bottom: AppSize.space[3],
        left: AppSize.space[4],
        right: AppSize.space[4],
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
