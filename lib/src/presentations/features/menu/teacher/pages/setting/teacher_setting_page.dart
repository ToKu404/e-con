import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:e_con/src/presentations/features/menu/teacher/providers/lecture_profile_notifier.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:e_con/src/presentations/widgets/dialog/confirm_logout.dart';
import 'package:e_con/src/presentations/widgets/econ_loading.dart';
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

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider = context.read<LectureProfileNotifier>();

    if (profileProvider.state == RequestState.loading) {
      return EconLoading();
    } else if (profileProvider.state == RequestState.error) {
      return Text(profileProvider.error);
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
                      borderRadius: BorderRadius.circular(AppSize.space[2]),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1614436163996-25cee5f54290?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=742&q=80',
                        ),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        width: 2,
                        color: Palette.primary,
                      ),
                    ),
                  ),
                ),
                AppSize.verticalSpace[3],
                Center(
                  child: Text(
                    lectureData.lectureName ?? '',
                    textAlign: TextAlign.center,
                    style: kTextHeme.headline5?.copyWith(
                      height: 1,
                    ),
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
                showConfirmLogout(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
