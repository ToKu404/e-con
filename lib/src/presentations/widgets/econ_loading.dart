import 'package:e_con/core/constants/color_const.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EconLoading extends StatelessWidget {
  const EconLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Palette.primary : Palette.secondary,
            ),
          );
        },
        size: 50.0,
      ),
    );
  }
}
