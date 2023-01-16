import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:flutter/material.dart';

class TeacherTaskCard extends StatelessWidget {
  const TeacherTaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.space[4],
      ),
      width: AppSize.getAppWidth(context),
      margin: EdgeInsets.only(
        bottom: AppSize.space[3],
      ),
      child: Row(
        children: [
          Flexible(
            flex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '10:00 AM',
                  style: kTextHeme.headline5,
                ),
                Text(
                  '12:00 AM',
                  style: kTextHeme.subtitle1?.copyWith(
                    color: Palette.disable,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          AppSize.horizontalSpace[3],
          Expanded(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            AppSize.space[3],
                          ),
                          bottomLeft: Radius.circular(
                            AppSize.space[3],
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(
                        AppSize.space[3],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Aljabar Terapan',
                                  style: kTextHeme.subtitle1?.copyWith(
                                    color: Palette.primary,
                                  ),
                                ),
                                Text(
                                  'Pertemuan 6',
                                  style: kTextHeme.subtitle2?.copyWith(
                                    color: Palette.onPrimary,
                                    height: 1.2,
                                  ),
                                ),
                                AppSize.verticalSpace[3],
                                Text(
                                  'Kelas A',
                                  style: kTextHeme.subtitle1?.copyWith(
                                    color: Palette.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 4,
                    color: Palette.primaryVariant,
                  ),
                  Container(
                    width: 6,
                    decoration: BoxDecoration(
                      color: Palette.primary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          AppSize.space[3],
                        ),
                        bottomRight: Radius.circular(
                          AppSize.space[3],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
