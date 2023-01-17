import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecture_profile_notifier.dart';
import 'package:e_con/src/presentations/features/menu/providers/profile_picture_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_error.dart';
import 'package:e_con/src/presentations/widgets/dialog/show_confirmation.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _AppBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSize.space[2]),
      width: AppSize.getAppWidth(context),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            offset: const Offset(1, 2),
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.space[4],
            ),
            child: Text(
              'Data Pengguna',
              style: kTextHeme.headline5?.copyWith(
                color: Palette.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
              onPressed: () async {
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
              icon: Icon(Icons.exit_to_app))
        ],
      ),
    );
  }
}

class TeacherSettingPage extends StatelessWidget {
  const TeacherSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AppBarSection(),
        Expanded(child: ProfileSection()),
      ],
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<LectureProfileNotifier>();
    final profilePictureProvider = context.watch<ProfilePictureNotifier>();

    if (profileProvider.state == RequestState.loading ||
        profileProvider.lectureData == null ||
        profilePictureProvider.state == RequestState.loading) {
      return EconLoading();
    } else if (profileProvider.state == RequestState.error) {
      return EconError(errorMessage: profileProvider.error);
    }
    final lectureData = profileProvider.lectureData!;
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
                          lectureData.name![0],
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
                lectureData.name ?? '',
                style: kTextHeme.headline2?.copyWith(
                    color: Palette.black,
                    fontWeight: FontWeight.w500,
                    height: 1.1),
              ),
              Text(
                'NIP. ${lectureData.idNumber ?? ''}',
                style: kTextHeme.headline6?.copyWith(
                    color: Palette.black,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )
            ],
          ),
        ),
        Divider(),
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
                lectureData.major?.degree ?? '',
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
                lectureData.major?.name ?? '',
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
                lectureData.major?.departmentData?.departmentName ?? '',
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

// class _ProfileCard extends StatefulWidget {
//   @override
//   State<_ProfileCard> createState() => _ProfileCardState();
// }

// class _ProfileCardState extends State<_ProfileCard> {
//   @override
//   Widget build(BuildContext context) {
//     final profileProvider = context.watch<LectureProfileNotifier>();
//     final profilePictureProvider = context.watch<ProfilePictureNotifier>();

//     if (profileProvider.state == RequestState.loading ||
//         profileProvider.lectureData == null ||
//         profilePictureProvider.state == RequestState.loading) {
//       return EconLoading();
//     } else if (profileProvider.state == RequestState.error) {
//       return EconError(errorMessage: profileProvider.error);
//     }
//     final lectureData = profileProvider.lectureData!;
//     return Container(
//       width: AppSize.getAppWidth(context) * 0.8,
//       padding: EdgeInsets.symmetric(
//           horizontal: AppSize.space[4], vertical: AppSize.space[6]),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(
//           AppSize.space[4],
//         ),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 10,
//             color: Palette.primaryVariant.withOpacity(
//               .34,
//             ),
//           ),
//           BoxShadow(
//             blurRadius: 3.19,
//             color: Palette.primaryVariant.withOpacity(
//               .20,
//             ),
//           ),
//           BoxShadow(
//             blurRadius: 1,
//             color: Palette.primaryVariant.withOpacity(
//               .13,
//             ),
//           ),
//         ],
//       ),
//       child: AspectRatio(
//         aspectRatio: .75,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         width: 2,
//                         color: Palette.disable,
//                       ),
//                       color: Palette.disable,
//                       image: profilePictureProvider.profilePicture != null
//                           ? DecorationImage(
//                               image: MemoryImage(
//                                   profilePictureProvider.profilePicture!),
//                               fit: BoxFit.cover)
//                           : null,
//                     ),
//                     child: profilePictureProvider.profilePicture == null
//                         ? Center(
//                             child: Text(
//                               lectureData.name![0],
//                               style: TextStyle(
//                                 fontSize: 40,
//                                 fontWeight: FontWeight.w600,
//                                 color: Palette.white,
//                               ),
//                             ),
//                           )
//                         : SizedBox.shrink(),
//                   ),
//                 ),
//                 AppSize.verticalSpace[3],
//                 Center(
//                   child: Text(
//                     lectureData.name ?? '',
//                     textAlign: TextAlign.center,
//                     style: kTextHeme.headline5
//                         ?.copyWith(height: 1, color: Palette.onPrimary),
//                   ),
//                 ),
//                 AppSize.verticalSpace[3],
//                 Center(
//                   child: Text(
//                     lectureData.idNumber ?? '',
//                     style: kTextHeme.subtitle1?.copyWith(
//                       color: Palette.disable,
//                       height: 1,
//                     ),
//                   ),
//                 ),
//                 AppSize.verticalSpace[5],
//                 Text(
//                   lectureData.major?.name ?? '',
//                   style: kTextHeme.subtitle1?.copyWith(
//                     color: Palette.disable,
//                     height: 1,
//                   ),
//                 ),
//                 Text(
//                   lectureData.major?.degree ?? '',
//                   style: kTextHeme.subtitle1?.copyWith(
//                     color: Palette.disable,
//                     height: 1,
//                   ),
//                 ),
//                 Text(
//                   lectureData.major?.departmentData?.departmentName ?? '',
//                   style: kTextHeme.subtitle1?.copyWith(
//                     color: Palette.disable,
//                     height: 1,
//                   ),
//                 ),
//               ],
//             ),
//             CustomButton(
//               text: 'Keluar',
//               onTap: () async {
//                 final logoutConfirmation = await showConfirmation(
//                     context: context,
//                     title: 'Apakah anda serius ingin keluar?');

//                 if (logoutConfirmation) {
//                   await context.read<AuthNotifier>()
//                     ..logOut();
//                   Navigator.pushNamedAndRemoveUntil(
//                     context,
//                     AppRoute.login,
//                     (route) => false,
//                   );
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
