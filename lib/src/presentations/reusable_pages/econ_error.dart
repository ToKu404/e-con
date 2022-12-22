import 'package:e_con/core/constants/color_const.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

class EconError extends StatelessWidget {
  final String errorMessage;
  const EconError({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: SvgPicture.asset(
            'assets/illustrations/error_vector.svg',
            fit: BoxFit.fitWidth,
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
