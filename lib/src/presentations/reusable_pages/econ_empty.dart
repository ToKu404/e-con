import 'package:e_con/core/constants/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EconEmpty extends StatelessWidget {
  final String emptyMessage;
  const EconEmpty({super.key, required this.emptyMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: SvgPicture.asset(
            'assets/illustrations/empty_vector.svg',
            fit: BoxFit.contain,
          ),
        ),
        Text(
          'Data Kosong',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          emptyMessage,
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
