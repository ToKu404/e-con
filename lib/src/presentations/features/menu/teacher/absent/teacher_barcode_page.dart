import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:flutter/material.dart';

class TeacherBarcodePage extends StatelessWidget {
  const TeacherBarcodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        leading: IconButton(
          icon: Icon(
            Icons.close_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Absen',
          style: kTextHeme.headline5?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.mode_edit_outline_outlined,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      backgroundColor: Palette.primary,
      body: Column(
        children: [Row()],
      ),
    );
  }
}
