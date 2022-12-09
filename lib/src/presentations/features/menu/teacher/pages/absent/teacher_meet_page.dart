import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/features/menu/teacher/pages/absent/widgets/teacher_meet_card.dart';
import 'package:e_con/src/presentations/widgets/choice_absent_modal.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TeacherMeetDetailPage extends StatelessWidget {
  const TeacherMeetDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Pertemuan 1',
          style: kTextHeme.headline5?.copyWith(
            color: Palette.primary,
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(
                    AppSize.space[3],
                  ),
                  color: Palette.primary,
                  child: Container(
                    padding: EdgeInsets.all(AppSize.space[3]),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSize.space[3],
                      ),
                      color: Colors.white,
                      border: Border.all(
                        color: Palette.disable.withOpacity(.5),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AbsentStatisticCard(
                              absentStatus: AbsentStatus.hadir,
                              value: 49,
                            ),
                            AppSize.horizontalSpace[2],
                            const AbsentStatisticCard(
                              absentStatus: AbsentStatus.izin,
                              value: 2,
                            ),
                          ],
                        ),
                        AppSize.verticalSpace[2],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AbsentStatisticCard(
                              absentStatus: AbsentStatus.sakit,
                              value: 3,
                            ),
                            AppSize.horizontalSpace[2],
                            const AbsentStatisticCard(
                              absentStatus: AbsentStatus.tidakHadir,
                              value: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const _CustomAppBar(),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSize.space[3],
                  horizontal: AppSize.space[3],
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(childCount: 10,
                      (context, index) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const ChoiceAbsentModal();
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            width: AppSize.getAppWidth(context),
                            padding: EdgeInsets.all(AppSize.space[3]),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                AppSize.space[3],
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Austin',
                                        style: kTextHeme.subtitle2?.copyWith(
                                          color: Palette.primaryVariant,
                                        ),
                                      ),
                                      Text(
                                        'H071191049',
                                        style: kTextHeme.subtitle1?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Palette.primary,
                                        ),
                                      ),
                                      Text(
                                        '05:30 08-02-2022',
                                        style: kTextHeme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSize.space[2],
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(
                                      AppSize.space[0],
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Palette.success,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                          'assets/icons/smile.svg'),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (index == 9)
                            const SizedBox(
                              height: 58,
                            )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withOpacity(.5),
                    Colors.white
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              width: AppSize.getAppWidth(context),
              padding: EdgeInsets.all(AppSize.space[3]),
              child: CustomButton(
                height: 54,
                icon: Icons.qr_code_2_rounded,
                text: 'Barcode Absen',
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.genBarcode);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatefulWidget {
  const _CustomAppBar();

  @override
  State<_CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<_CustomAppBar> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              offset: const Offset(1, 0),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          children: [
            AppSize.verticalSpace[3],
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.space[3],
              ),
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
            AppSize.verticalSpace[3],
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  AppSize.horizontalSpace[3],
                  const CustomChip(
                    title: 'Nama',
                    haveShowMore: true,
                  ),
                  const CustomChip(
                    title: 'Hadir',
                  ),
                  const CustomChip(
                    title: 'Izin',
                  ),
                  const CustomChip(
                    title: 'Sakit',
                  ),
                ],
              ),
            ),
            AppSize.verticalSpace[5],
          ],
        ),
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  final String title;
  final bool haveShowMore;
  const CustomChip({
    super.key,
    required this.title,
    this.haveShowMore = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: AppSize.space[2]),
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.space[4],
        ),
        border: Border.all(
          color: Palette.disable,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.space[3],
        vertical: AppSize.space[1],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: kTextHeme.subtitle2?.copyWith(
              color: Palette.onPrimary,
            ),
          ),
          if (haveShowMore)
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: Palette.onPrimary,
            ),
        ],
      ),
    );
  }
}

class AbsentStatisticCard extends StatelessWidget {
  final int value;
  final AbsentStatus absentStatus;
  const AbsentStatisticCard({
    super.key,
    required this.value,
    required this.absentStatus,
  });

  @override
  Widget build(BuildContext context) {
    final data = {
      AbsentStatus.hadir: AbsentData(
        color: Palette.success,
        title: 'Hadir',
        path: 'assets/icons/smile.svg',
      ),
      AbsentStatus.izin: AbsentData(
        color: Colors.blue,
        title: 'Izin',
        path: 'assets/icons/natural.svg',
      ),
      AbsentStatus.sakit: AbsentData(
        color: Palette.warning,
        title: 'Sakit',
        path: 'assets/icons/sick.svg',
      ),
      AbsentStatus.tidakHadir: AbsentData(
        color: Palette.danger,
        title: 'Alfa',
        path: 'assets/icons/unhappy.svg',
      ),
    };

    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSize.space[3],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.space[2],
          ),
          border: Border.all(
            color: data[absentStatus]!.color,
          ),
        ),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: kTextHeme.headline1?.copyWith(
                color: Palette.onPrimary,
                height: 1,
              ),
            ),
            AppSize.verticalSpace[0],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  data[absentStatus]!.path!,
                  height: 14,
                  width: 14,
                ),
                AppSize.horizontalSpace[1],
                Text(
                  data[absentStatus]!.title,
                  style: kTextHeme.subtitle1?.copyWith(
                    color: data[absentStatus]!.color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
