import 'package:e_con/core/constants/color_const.dart';
import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  Color? color;

  GridPainter({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    const double step = 20;

    final paint = Paint()
      ..color = color ?? Palette.black.withOpacity(.1)
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
