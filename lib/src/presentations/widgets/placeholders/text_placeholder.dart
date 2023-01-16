import 'package:e_con/core/constants/size_const.dart';
import 'package:flutter/material.dart';

class TextPlaceholder extends StatelessWidget {
  const TextPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppSize.getAppWidth(context) * .8,
          height: 25,
          margin: EdgeInsets.only(
            left: AppSize.space[2],
            right: AppSize.space[2],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppSize.space[0],
            ),
          ),
        ),
        AppSize.verticalSpace[1],
        Container(
          width: AppSize.getAppWidth(context) * .6,
          height: 25,
          margin: EdgeInsets.only(
            left: AppSize.space[2],
            right: AppSize.space[2],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppSize.space[0],
            ),
          ),
        ),
      ],
    );
  }
}
