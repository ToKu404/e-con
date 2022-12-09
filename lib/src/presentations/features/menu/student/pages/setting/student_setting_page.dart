import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/login/provider/auth_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_profile_notifier.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:e_con/src/presentations/widgets/econ_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentSettingPage extends StatelessWidget {
  const StudentSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AppBarSection(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: _ProfileCard(),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _AppBarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.space[4]),
      width: AppSize.getAppWidth(context),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pengaturan',
            style: kTextHeme.headline5?.copyWith(
              color: Palette.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider = context.read<StudentProfileNotifier>();

    if (profileProvider.state == RequestState.loading) {
      return EconLoading();
    } else if (profileProvider.state == RequestState.error) {
      return Text(profileProvider.error);
    }

    final studentData = profileProvider.studentData!;

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
      child: Column(
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
          AppSize.verticalSpace[1],
          Center(
            child: Text(
              studentData.studentName ?? '',
              style: kTextHeme.headline5,
            ),
          ),
          Center(
            child: Text(
              studentData.studentId ?? '',
              style: kTextHeme.subtitle1?.copyWith(
                color: Palette.disable,
                height: 1,
              ),
            ),
          ),
          AppSize.verticalSpace[3],
          Text(
            'Jenis Kelamin',
            style: kTextHeme.subtitle2?.copyWith(
              color: Palette.disable,
            ),
          ),
          Text(
            studentData.studentGender ?? '',
            style: kTextHeme.subtitle1?.copyWith(
              color: Palette.primary,
              height: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSize.verticalSpace[4],
          Text(
            'Program Studi',
            style: kTextHeme.subtitle2?.copyWith(
              color: Palette.disable,
            ),
          ),
          Text(
            studentData.studyProgram != null
                ? studentData.studyProgram!.name!
                : '',
            style: kTextHeme.subtitle1?.copyWith(
              color: Palette.primary,
              height: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSize.verticalSpace[4],
          CustomButton(
            text: 'Keluar',
            onTap: () async {
              await context.read<AuthNotifier>()
                ..logOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.login,
                (route) => false,
              );
            },
          )
        ],
      ),
    );
  }
}
