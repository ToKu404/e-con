import 'package:e_con/core/constants/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EconError extends StatelessWidget {
  final String errorMessage;
  final bool withScaffold;
  const EconError(
      {super.key, required this.errorMessage, this.withScaffold = false});

  @override
  Widget build(BuildContext context) {
    return withScaffold
        ? Scaffold(
            backgroundColor: Palette.background,
            body: content(),
          )
        : content();
  }

  Widget content() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          width: 250,
          child: SvgPicture.asset(
            'assets/illustrations/error_vector.svg',
            fit: BoxFit.contain,
          ),
        ),
        Text(
          'Error',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          errorMessage,
          maxLines: 3,
          style: TextStyle(
            height: 1,
            fontSize: 14,
            color: Palette.disable,
          ),
        )
      ],
    ));
  }
}
