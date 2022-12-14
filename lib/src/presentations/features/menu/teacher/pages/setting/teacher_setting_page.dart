import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/lecture_profile_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:e_con/src/presentations/widgets/dialog/show_confirmation.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherSettingPage extends StatelessWidget {
  const TeacherSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Pengaturan',
          style: kTextHeme.headline5?.copyWith(
            fontWeight: FontWeight.bold,
            color: Palette.primary,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: _ProfileCard(),
          )
        ],
      ),
    );
  }
}

class _ProfileCard extends StatefulWidget {
  @override
  State<_ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<_ProfileCard> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<LectureProfileNotifier>(context, listen: false)
        ..getStudentData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.read<LectureProfileNotifier>();

    if (profileProvider.state == RequestState.loading ||
        profileProvider.lectureData == null) {
      return EconLoading();
    } else if (profileProvider.state == RequestState.error) {
      return EconError(errorMessage: profileProvider.error);
    }

    final lectureData = profileProvider.lectureData!;
    return Container(
      width: AppSize.getAppWidth(context) * 0.8,
      padding: EdgeInsets.symmetric(
          horizontal: AppSize.space[4], vertical: AppSize.space[6]),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.space[4],
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Palette.onPrimary.withOpacity(
              .34,
            ),
          ),
          BoxShadow(
            blurRadius: 3.19,
            color: Palette.onPrimary.withOpacity(
              .20,
            ),
          ),
          BoxShadow(
            blurRadius: 1,
            color: Palette.onPrimary.withOpacity(
              .13,
            ),
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: .75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Palette.disable,
                        ),
                        color: Palette.disable),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 36,
                        color: Palette.background,
                      ),
                    ),
                  ),
                ),
                AppSize.verticalSpace[3],
                Center(
                  child: Text(
                    lectureData.lectureName ?? '',
                    textAlign: TextAlign.center,
                    style: kTextHeme.headline5
                        ?.copyWith(height: 1, color: Palette.onPrimary),
                  ),
                ),
                AppSize.verticalSpace[3],
                Center(
                  child: Text(
                    lectureData.lectureNIP != null
                        ? 'NIP. ${lectureData.lectureNIP}'
                        : lectureData.lectureNIDN != null
                            ? 'NIDN. ${lectureData.lectureNIDN}'
                            : '-',
                    style: kTextHeme.subtitle1?.copyWith(
                      color: Palette.disable,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
            CustomButton(
              text: 'Keluar',
              onTap: () async {
                final logoutConfirmation = await showConfirmation(
                    context: context,
                    title: 'Apakah anda serius ingin keluar?');

                if (logoutConfirmation) {
                  await context.read<AuthNotifier>()
                    ..logOut();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoute.login,
                    (route) => false,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
