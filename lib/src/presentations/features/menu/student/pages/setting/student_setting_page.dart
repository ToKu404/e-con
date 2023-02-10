import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:e_con/src/presentations/features/menu/providers/profile_picture_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_profile_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/check_internet_onetime.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/widgets/default_appbar.dart';
import 'package:e_con/src/presentations/widgets/dialog/show_confirmation.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentSettingPage extends StatelessWidget {
  const StudentSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultAppBar(
          title: 'Data Pengguna',
          action: IconButton(
            onPressed: () async {
              final logoutConfirmation = await showConfirmation(
                  context: context, title: 'Apakah anda serius ingin keluar?');

              if (logoutConfirmation) {
                await context.read<AuthNotifier>()
                  ..logOut();
                Future.delayed(
                  Duration(seconds: 1),
                  () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.login,
                      (route) => false,
                    );
                  },
                );
              }
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ),
        Expanded(
          child: CheckInternetOnetime(child: (context) {
            return ProfileSection();
          }),
        )
      ],
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<StudentProfileNotifier>();
    final profilePictureProvider = context.watch<ProfilePictureNotifier>();

    if (profileProvider.state == RequestState.loading ||
        profileProvider.studentData == null ||
        profilePictureProvider.state == RequestState.loading) {
      return EconLoading();
    } else if (profileProvider.state == RequestState.error) {
      return EconError(errorMessage: profileProvider.error);
    }
    final studentData = profileProvider.studentData!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            SizedBox(
              width: AppSize.getAppWidth(context),
              height: 160,
            ),
            Container(
              height: 100,
              width: AppSize.getAppWidth(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Palette.primary,
                    Palette.primaryVariant,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: Palette.background,
                  ),
                  color: Palette.disable,
                  image: profilePictureProvider.profilePicture != null
                      ? DecorationImage(
                          image: MemoryImage(
                              profilePictureProvider.profilePicture!),
                          fit: BoxFit.cover)
                      : null,
                ),
                child: profilePictureProvider.profilePicture == null
                    ? Center(
                        child: Text(
                          studentData.name![0],
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Palette.white,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                studentData.name ?? '',
                style: kTextHeme.headline2?.copyWith(
                    color: Palette.black,
                    fontWeight: FontWeight.w500,
                    height: 1.1),
              ),
              Text(
                'NIM. ${studentData.nim ?? ''}',
                style: kTextHeme.headline6?.copyWith(
                    color: Palette.black,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )
            ],
          ),
        ),
        Divider(
          color: Palette.disable,
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jenjang',
                style: kTextHeme.subtitle1?.copyWith(color: Palette.disable),
              ),
              Text(
                studentData.major?.degree ?? '',
                style: kTextHeme.subtitle1?.copyWith(
                    color: Palette.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1),
              ),
              AppSize.verticalSpace[4],
              Text(
                'Program Studi',
                style: kTextHeme.subtitle1?.copyWith(color: Palette.disable),
              ),
              Text(
                studentData.major?.name ?? '',
                style: kTextHeme.subtitle1?.copyWith(
                    color: Palette.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1),
              ),
              AppSize.verticalSpace[4],
              Text(
                'Departemen',
                style: kTextHeme.subtitle1?.copyWith(color: Palette.disable),
              ),
              Text(
                studentData.major?.departmentData?.departmentName ?? '',
                style: kTextHeme.subtitle1?.copyWith(
                    color: Palette.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1),
              )
            ],
          ),
        )
      ],
    );
  }
}
