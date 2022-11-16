import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChoiceAbsentModal extends StatelessWidget {
  const ChoiceAbsentModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSize.space[2],
        ),
      ),
      elevation: 1,
      backgroundColor: Colors.transparent,
      child: contentSuccess(context),
    );
  }

  Widget contentSuccess(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.space[2],
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close_rounded,
                ),
              ),
              Expanded(
                child: Text(
                  'Ubah Status Absensi',
                  textAlign: TextAlign.center,
                  style: kTextHeme.subtitle1?.copyWith(
                    color: Palette.onPrimary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.check_rounded,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: AppSize.space[5],
              right: AppSize.space[5],
              bottom: AppSize.space[3],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Absensi',
                  style: kTextHeme.subtitle2,
                ),
                Text(
                  'Eurico Devon',
                  style: kTextHeme.headline5?.copyWith(
                    color: Palette.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSize.verticalSpace[3],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppSize.space[3],
                            ),
                            color: Palette.background,
                          ),
                          child: Center(
                            child: SizedBox(
                              height: 35,
                              width: 35,
                              child: SvgPicture.asset(
                                'assets/icons/unhappy.svg',
                                color: Palette.disable,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Alfa',
                          style: kTextHeme.subtitle2?.copyWith(
                            color: Palette.disable,
                          ),
                        ),
                      ],
                    ),
                    AppSize.horizontalSpace[2],
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppSize.space[3],
                            ),
                            color: Palette.background,
                          ),
                          child: Center(
                            child: SizedBox(
                              height: 35,
                              width: 35,
                              child: SvgPicture.asset(
                                'assets/icons/natural.svg',
                                color: Palette.disable,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Izin',
                          style: kTextHeme.subtitle2?.copyWith(
                            color: Palette.disable,
                          ),
                        ),
                      ],
                    ),
                    AppSize.horizontalSpace[2],
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppSize.space[3],
                            ),
                            color: Palette.background,
                          ),
                          child: Center(
                            child: SizedBox(
                              height: 35,
                              width: 35,
                              child: SvgPicture.asset(
                                'assets/icons/sick.svg',
                                color: Palette.disable,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Sakit',
                          style: kTextHeme.subtitle2?.copyWith(
                            color: Palette.disable,
                          ),
                        ),
                      ],
                    ),
                    AppSize.horizontalSpace[2],
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppSize.space[3],
                            ),
                            color: Palette.background,
                          ),
                          child: Center(
                            child: SizedBox(
                              height: 35,
                              width: 35,
                              child: SvgPicture.asset(
                                'assets/icons/smile.svg',
                                color: Palette.disable,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Hadir',
                          style: kTextHeme.subtitle2?.copyWith(
                            color: Palette.disable,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
