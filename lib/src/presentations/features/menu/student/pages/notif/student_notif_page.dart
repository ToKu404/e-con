import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:flutter/material.dart';

class StudentNotifPage extends StatelessWidget {
  const StudentNotifPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: const [
            SizedBox(
              height: 60,
            ),
            Expanded(
              child: _BodySection(),
            ),
          ],
        ),
        _AppBarSection()
      ],
    );
  }
}

class _AppBarSection extends StatelessWidget {
  const _AppBarSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: AppSize.space[4]),
      width: AppSize.getAppWidth(context),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.15),
          offset: const Offset(1, 2),
          blurRadius: 1,
        ),
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Notifikasi',
                style: kTextHeme.headline5?.copyWith(
                  color: Palette.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSize.horizontalSpace[0],
              Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(left: AppSize.space[1]),
                padding: EdgeInsets.all(AppSize.space[0]),
                decoration: BoxDecoration(
                  color: Palette.primary,
                  borderRadius: BorderRadius.circular(AppSize.space[0]),
                ),
                child: Center(
                  child: Text(
                    '2',
                    style: kTextHeme.overline?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
      itemCount: 10,
      itemBuilder: (context, index) {
        return _StudentNotifCard();
      },
    );
  }
}

class _StudentNotifCard extends StatelessWidget {
  const _StudentNotifCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.getAppWidth(context),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Palette.background,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          AppSize.space[3],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Hari Ini',
                style: kTextHeme.overline?.copyWith(
                  color: Palette.onPrimary,
                  height: 1,
                ),
              ),
            ),
            Text(
              'Lorem',
              style: kTextHeme.subtitle2?.copyWith(
                color: Palette.disable,
                height: 1.2,
              ),
            ),
            Text(
              'Lorem Ipsum',
              style: kTextHeme.subtitle1?.copyWith(
                color: Palette.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Lorem 23',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: kTextHeme.subtitle2?.copyWith(
                color: Palette.disable,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
