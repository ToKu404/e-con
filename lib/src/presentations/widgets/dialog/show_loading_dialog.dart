import 'dart:ui';

import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> showLoadingDialog({
  required BuildContext context,
}) async {
  await showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.circular(AppSize.borderRadius),
                ),
                child: Center(
                  child: SpinKitFadingCircle(
                    itemBuilder: (_, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isEven
                              ? Palette.primary
                              : Palette.secondary,
                        ),
                      );
                    },
                    size: 50.0,
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
