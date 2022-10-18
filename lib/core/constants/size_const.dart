import 'package:flutter/widgets.dart';

class AppSize {
  static const double borderRadius = 12.0;
  static double getAppWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double getAppHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static final List verticalSpace = [2.0, 4.0, 8.0, 12.0, 16.0, 20.0, 24.0]
      .map((height) => SizedBox(height: height))
      .toList();
  static final List horizontalSpace = [2.0, 4.0, 8.0, 12.0, 16.0, 20.0, 24.0]
      .map((height) => SizedBox(height: height))
      .toList();
}
