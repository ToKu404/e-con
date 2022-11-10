import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StudentHistoryPage extends StatelessWidget {
  const StudentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AppBarSection(),
        const Expanded(
          child: _BodySection(),
        ),
      ],
    );
  }
}

class _AppBarSection extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.space[4]),
      width: AppSize.getAppWidth(context),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Palette.disable,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Riwayat Kehadiran',
            style: kTextHeme.headline5?.copyWith(
              color: Palette.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSize.verticalSpace[3],
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {},
                  keyboardType: TextInputType.text,
                  style: kTextHeme.subtitle1?.copyWith(
                    color: Palette.onPrimary,
                  ),
                  cursorColor: Palette.primary,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    hintText: 'Pencarian',
                    hintStyle: kTextHeme.subtitle1,
                    filled: true,
                    prefixIcon: const SizedBox(
                      height: 12,
                      width: 12,
                      child: Icon(
                        Icons.search,
                        color: Palette.disable,
                      ),
                    ),
                    prefixIconColor: Palette.disable,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.background),
                      borderRadius: BorderRadius.circular(
                        AppSize.space[3],
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.primary),
                      borderRadius: BorderRadius.circular(
                        AppSize.space[3],
                      ),
                    ),
                    // errorText: !state.isEmailValid
                    //     ? 'Please ensure the email entered is valid'
                    //     : null,
                    // labelText: 'Email',
                  ),
                ),
              ),
              AppSize.horizontalSpace[2],
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Palette.primary,
                ),
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/filter.svg'),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _BodySection extends StatelessWidget {
  const _BodySection();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(
        AppSize.space[3],
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            bottom: AppSize.space[2],
          ),
          width: AppSize.getAppWidth(context),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              AppSize.space[3],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              AppSize.space[3],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Senin, 12 Januari 2023',
                        style: kTextHeme.subtitle2?.copyWith(
                          color: Palette.disable,
                        ),
                      ),
                      Text(
                        'Pertemuan 1',
                        style: kTextHeme.subtitle1?.copyWith(
                          color: Palette.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Matematika Dasar',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: kTextHeme.subtitle2?.copyWith(
                          color: Palette.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 50,
                  padding: EdgeInsets.all(AppSize.space[0]),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSize.space[2],
                    ),
                    color: Palette.success.withOpacity(.2),
                  ),
                  child: Center(
                    child: Text(
                      'Hadir',
                      style: kTextHeme.overline?.copyWith(
                        color: Palette.success,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
