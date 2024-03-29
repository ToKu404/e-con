import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/path_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EconNoInternet extends StatelessWidget {
  final bool withScaffold;
  final VoidCallback onReload;
  const EconNoInternet(
      {super.key, this.withScaffold = false, required this.onReload});

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
            AssetPath.disconnectIllustration,
            fit: BoxFit.contain,
          ),
        ),
        Text(
          'Koneksi Terputus',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          'Harap periksa sambungan internet anda',
          maxLines: 3,
          style: TextStyle(
            height: 1,
            fontSize: 14,
            color: Palette.disable,
          ),
        ),
        SizedBox(
          height: 32,
        ),
        IconButton(
          onPressed: onReload,
          style: IconButton.styleFrom(
            backgroundColor: Palette.primaryVariant,
          ),
          icon: Icon(
            Icons.replay_outlined,
            color: Palette.white,
          ),
        ),
      ],
    ));
  }
}
