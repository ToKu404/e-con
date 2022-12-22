import 'package:e_con/core/constants/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EconLoading extends StatelessWidget {
  final bool withScaffold;
  const EconLoading({super.key, this.withScaffold = false});

  @override
  Widget build(BuildContext context) {
    return withScaffold
        ? Scaffold(
            body: content(),
            backgroundColor: Palette.background,
          )
        : content();
  }

  Center content() {
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
