import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/helpers/final_exam_helper.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/presentations/features/menu/lecturer/providers/lecturer_seminars_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/pages/final_exam/student_final_exam_detail.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LecturerSeminarDetailPage extends StatefulWidget {
  final int seminarId;
  const LecturerSeminarDetailPage({super.key, required this.seminarId});

  @override
  State<LecturerSeminarDetailPage> createState() =>
      _LecturerSeminarDetailPageState();
}

class _LecturerSeminarDetailPageState extends State<LecturerSeminarDetailPage> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<LecturerSeminarNotifier>(context, listen: false)
        ..getDetailSeminar(widget.seminarId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LecturerSeminarNotifier>();

    if (provider.detailState == RequestState.loading ||
        provider.detailSeminar == null) {
      return EconLoading(
        withScaffold: true,
      );
    }

    final detailSeminar = provider.detailSeminar!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Seminar',
          style: kTextHeme.headline5?.copyWith(
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                seminarType[detailSeminar.examType!]!,
                style: kTextHeme.headline4?.copyWith(color: Palette.onPrimary),
              ),
              Text(
                  "\"${ReusableFunctionHelper.titleMaker(detailSeminar.finalExamData!.title!)}\""),
              SizedBox(
                height: 8,
              ),
              Divider(
                color: Palette.disable,
              ),
              SizedBox(
                height: 8,
              ),
              BuildFeCard(
                child: [
                  Text(
                    'Mahasiswa',
                    style: kTextHeme.headline5?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Palette.onPrimary),
                  ),
                  Divider(
                    color: Palette.disable,
                  ),
                  Text(
                    'Nama',
                    style: kTextHeme.subtitle1?.copyWith(
                        color: Palette.disable, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    detailSeminar.finalExamData!.student!.name!,
                    style: kTextHeme.subtitle1,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'NIM',
                    style: kTextHeme.subtitle1?.copyWith(
                        color: Palette.disable, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    detailSeminar.finalExamData!.student!.nim!,
                    style: kTextHeme.subtitle1,
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              BuildFeCard(child: [
                Text(
                  'Tim Pembimbing',
                  style: kTextHeme.headline5?.copyWith(
                      fontWeight: FontWeight.normal, color: Palette.onPrimary),
                ),
                Divider(
                  color: Palette.disable,
                ),
               
                for (int i = 0;
                    i < detailSeminar.finalExamData!.listSupervisor!.length;
                    i++) ...[
                  Text(
                    'Pembimbing ${detailSeminar.finalExamData!.listSupervisor![i].supervisorPosition}',
                    style: kTextHeme.subtitle1?.copyWith(
                        color: Palette.disable, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    detailSeminar
                        .finalExamData!.listSupervisor![i].lecturer!.name!,
                    style: kTextHeme.subtitle1,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ]
              ]),
              SizedBox(
                height: 12,
              ),
              BuildFeCard(child: [
                Text(
                  'Tim Penguji',
                  style: kTextHeme.headline5?.copyWith(
                      fontWeight: FontWeight.normal, color: Palette.onPrimary),
                ),
                Divider(
                  color: Palette.disable,
                ),
                for (int i = 0;
                    i < detailSeminar.finalExamData!.listExaminer!.length;
                    i++) ...[
                  Text(
                    'Penguji ${detailSeminar.finalExamData!.listExaminer![i].order}',
                    style: kTextHeme.subtitle1?.copyWith(
                        color: Palette.disable, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    detailSeminar
                        .finalExamData!.listExaminer![i].lecturer!.name!,
                    style: kTextHeme.subtitle1,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ]
              ]),
              SizedBox(
                height: 12,
              ),
              BuildFeCard(child: [
                Text(
                  'Jadwal',
                  style: kTextHeme.headline5?.copyWith(
                      fontWeight: FontWeight.normal, color: Palette.onPrimary),
                ),
               Divider(
                  color: Palette.disable,
                ),
                Text(
                  'Hari, Tanggal',
                  style: kTextHeme.subtitle1?.copyWith(
                      color: Palette.disable, fontWeight: FontWeight.normal),
                ),
                Text(
                  ReusableFunctionHelper.datetimeToString(detailSeminar.date!),
                  style: kTextHeme.subtitle1,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Pukul',
                  style: kTextHeme.subtitle1?.copyWith(
                      color: Palette.disable, fontWeight: FontWeight.normal),
                ),
                Text(
                  '${detailSeminar.startTime}-${detailSeminar.endTime} WITA',
                  style: kTextHeme.subtitle1,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Tempat',
                  style: kTextHeme.subtitle1?.copyWith(
                      color: Palette.disable, fontWeight: FontWeight.normal),
                ),
                if (detailSeminar.place != null)
                  Text(
                    'Offline : ${detailSeminar.place}',
                    style: kTextHeme.subtitle1,
                  ),
                if (detailSeminar.link != null)
                  Text(
                    'Online : ${detailSeminar.link!.split(':')[1].trim()}',
                    style: kTextHeme.subtitle1,
                  ),
              ])
            ],
          ),
        ),
      )),
    );
  }
}
