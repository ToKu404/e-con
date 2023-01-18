import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/history/provider/attendance_history_notifier.dart';
import 'package:e_con/src/presentations/features/menu/widgets/class_card.dart';
import 'package:e_con/src/presentations/widgets/custom_shimmer.dart';
import 'package:e_con/src/presentations/widgets/placeholders/card_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class StudentHistoryPage extends StatelessWidget {
  const StudentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _AppBarSection(),
            const Expanded(
              child: _BodySection(),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          child: _AppBarSection(),
        )
      ],
    );
  }
}

class _AppBarSection extends StatefulWidget {
  @override
  State<_AppBarSection> createState() => _AppBarSectionState();
}

class _AppBarSectionState extends State<_AppBarSection> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppSize.space[4], vertical: AppSize.space[5]),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Riwayat Kehadiran',
            style: kTextHeme.headline5?.copyWith(
              color: Palette.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          // AppSize.verticalSpace[3],
          // Row(
          //   children: [
          //     Expanded(
          //       child: TextField(
          //         controller: searchController,
          //         onChanged: (value) {},
          //         keyboardType: TextInputType.text,
          //         style: kTextHeme.subtitle1?.copyWith(
          //           color: Palette.onPrimary,
          //         ),
          //         cursorColor: Palette.primary,
          //         decoration: InputDecoration(
          //           contentPadding: EdgeInsets.zero,
          //           isDense: true,
          //           hintText: 'Pencarian',
          //           hintStyle:
          //               kTextHeme.subtitle1?.copyWith(color: Palette.disable),
          //           filled: true,
          //           prefixIcon: const SizedBox(
          //             height: 12,
          //             width: 12,
          //             child: Icon(
          //               Icons.search,
          //               color: Palette.disable,
          //             ),
          //           ),
          //           prefixIconColor: Palette.disable,
          //           fillColor: Palette.field,
          //           enabledBorder: OutlineInputBorder(
          //             borderSide: const BorderSide(color: Palette.field),
          //             borderRadius: BorderRadius.circular(
          //               AppSize.space[3],
          //             ),
          //           ),
          //           focusedBorder: OutlineInputBorder(
          //             borderSide: const BorderSide(color: Palette.primary),
          //             borderRadius: BorderRadius.circular(
          //               AppSize.space[3],
          //             ),
          //           ),
          //           // errorText: !state.isEmailValid
          //           //     ? 'Please ensure the email entered is valid'
          //           //     : null,
          //           // labelText: 'Email',
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}

class _BodySection extends StatefulWidget {
  const _BodySection();

  @override
  State<_BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<_BodySection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AttendanceHistoryNotifier>(context, listen: false)
          .fetchListStudentClasses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AttendanceHistoryNotifier>();

    if (provider.studentClassesState == RequestState.loading ||
        provider.listStudentClass == null) {
      return CustomShimmer(
          child: Column(
        children: [
          AppSize.verticalSpace[4],
          CardPlaceholder(
            height: 120,
            horizontalPadding: AppSize.space[4],
          ),
          AppSize.verticalSpace[4],
          CardPlaceholder(
            height: 120,
            horizontalPadding: AppSize.space[4],
          ),
          AppSize.verticalSpace[4],
          CardPlaceholder(
            height: 120,
            horizontalPadding: AppSize.space[4],
          ),
        ],
      ));
    }

    final listClazzData = provider.listStudentClass;

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: AppSize.space[4],
      ),
      itemCount: listClazzData?.length,
      itemBuilder: (context, index) {
        return ClassCard(
          clazzData: listClazzData![index],
          onTap: () => Navigator.pushNamed(
            context,
            AppRoute.listStudentClasses,
            arguments: listClazzData[index],
          ),
        );
      },
    );
  }
}
