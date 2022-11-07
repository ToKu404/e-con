import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12,
          ),
          color: Palette.primary,
          border: Border.all(
            width: 1,
            color: Colors.white,
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 10,
              color: Palette.onPrimary.withOpacity(
                .34,
              ),
            ),
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 3.19,
              color: Palette.onPrimary.withOpacity(
                .20,
              ),
            ),
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 1,
              color: Palette.onPrimary.withOpacity(
                .13,
              ),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: kTextHeme.subtitle1?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
