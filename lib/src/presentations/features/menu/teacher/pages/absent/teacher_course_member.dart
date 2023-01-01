import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:flutter/material.dart';

class TeacherCourseMember extends StatelessWidget {
  const TeacherCourseMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Palette.primary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Peserta Matakuliah',
          style: kTextHeme.headline5?.copyWith(
            fontWeight: FontWeight.bold,
            color: Palette.primary,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.all(AppSize.space[4]),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              bottom: AppSize.space[3],
            ),
            width: AppSize.getAppWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppSize.space[2],
              ),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(AppSize.space[4]),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Austin',
                        style: kTextHeme.subtitle2?.copyWith(
                          color: Palette.primary,
                        ),
                      ),
                      Text(
                        'H071191049',
                        style: kTextHeme.subtitle1?.copyWith(
                          color: Palette.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        color: Palette.success,
                        strokeWidth: 5,
                        backgroundColor: Palette.disable,
                        value: .6,
                      ),
                    ),
                    Positioned.fill(
                        child: Center(
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: '75',
                              style: kTextHeme.subtitle2?.copyWith(
                                color: Palette.success,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: '%',
                                  style: kTextHeme.overline?.copyWith(
                                    color: Palette.success,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
