import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/helpers/final_exam_helper.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/final_exam/fe_exam.dart';
import 'package:e_con/src/data/models/final_exam/fe_proposed_thesis.dart';
import 'package:e_con/src/data/models/final_exam/fe_seminar.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_final_exam_helper_notifier.dart';
import 'package:e_con/src/presentations/features/menu/student/providers/student_final_exam_notifier.dart';
import 'package:e_con/src/presentations/reusable_pages/check_internet_onetime.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentFinalExamDetail extends StatefulWidget {
  const StudentFinalExamDetail({super.key});

  @override
  State<StudentFinalExamDetail> createState() => _StudentFinalExamDetailState();
}

class _StudentFinalExamDetailState extends State<StudentFinalExamDetail> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => {
        Provider.of<StudentFinalExamNotifier>(context, listen: false)
          ..getProposedThesis(),
        Provider.of<StudentFinalExamNotifier>(context, listen: false)
          ..getSeminars(),
        Provider.of<StudentFinalExamNotifier>(context, listen: false)
          ..getThesisTrialExam(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tugas Akhir',
          style: kTextHeme.headline5?.copyWith(
            color: Palette.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: CheckInternetOnetime(child: (context) {
        final provider = context.watch<StudentFinalExamNotifier>();
        if (provider.trialExamState == RequestState.loading ||
            provider.seminarsState == RequestState.loading ||
            provider.proposedThesisState == RequestState.loading) {
          return EconLoading();
        }

        return _BuildBody(
          feSeminar: provider.listSeminar,
          proposedThesis: provider.listProposedThesis,
          feExam: provider.thesisTrialExam,
        );
      }),
    );
  }
}

class _BuildBody extends StatefulWidget {
  final List<FeProposedThesis> proposedThesis;
  final List<FeSeminar> feSeminar;
  final FeExam? feExam;
  const _BuildBody(
      {required this.proposedThesis, required this.feSeminar, this.feExam});

  @override
  State<_BuildBody> createState() => __BuildBodyState();
}

class __BuildBodyState extends State<_BuildBody> {
  @override
  void initState() {
    Future.microtask(
      () => {
        Provider.of<StudentFinalExamHelperNotifier>(context, listen: false)
          ..acceptedThesisInit(
              context: context, listProposedThesis: widget.proposedThesis),
        Provider.of<StudentFinalExamHelperNotifier>(context, listen: false)
          ..seminarInit(context: context, listSeminar: widget.feSeminar),
        Provider.of<StudentFinalExamHelperNotifier>(context, listen: false)
          ..trialExamInit(context: context, exam: widget.feExam),
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentFinalExamHelperNotifier>();
    if (provider.proposedThesisState == RequestState.loading ||
        provider.seminarState == RequestState.loading ||
        provider.trialExamState == RequestState.loading) {
      return EconLoading();
    }
    final finalExamObject = provider.homeFinalExamDta.first;
    final acceptedThesis = provider.acceptedThesis;
    final proposedSeminar = provider.proposedSeminar;
    final resultSeminar = provider.resultSeminar;
    final finalExam = provider.finalExam;
    final trialExam = provider.trialExam;

    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1, milliseconds: 500)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Judul'),
                Text(
                  '\"${ReusableFunctionHelper.titleMaker(acceptedThesis?.title ?? '')}\"',
                  style: kTextHeme.headline4?.copyWith(
                    color: Palette.onPrimary,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: finalExamObject.color,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    finalExamObject.status,
                    style: kTextHeme.subtitle2,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  color: Palette.disable,
                ),
                if (proposedSeminar != null)
                  ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Text(
                      'Tugas Akhir',
                    ),
                    initiallyExpanded: false,
                    children: [
                      BuildFeCard(child: [
                        Text(
                          'Dosen Pembimbing',
                          style: kTextHeme.headline5?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Palette.primaryVariant),
                        ),
                        Divider(
                          color: Palette.disable,
                        ),
                        for (int i = 0;
                            i <
                                proposedSeminar
                                    .finalExamData!.listSupervisor!.length;
                            i++) ...[
                          Text(
                            'Pembimbing ${proposedSeminar.finalExamData!.listSupervisor![i].supervisorPosition}',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            proposedSeminar.finalExamData!.listSupervisor![i]
                                .lecturer!.name!,
                            style: kTextHeme.subtitle1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ]),
                      SizedBox(
                        height: 16,
                      ),
                      BuildFeCard(
                        child: [
                          Text(
                            'Dosen Penguji',
                            style: kTextHeme.headline5?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Palette.primaryVariant),
                          ),
                          Divider(
                            color: Palette.disable,
                          ),
                          for (int i = 0;
                              i <
                                  proposedSeminar
                                      .finalExamData!.listExaminer!.length;
                              i++) ...[
                            Text(
                              'Penguji ${proposedSeminar.finalExamData!.listExaminer![i].order}',
                              style: kTextHeme.subtitle1?.copyWith(
                                  color: Palette.disable,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              proposedSeminar.finalExamData!.listExaminer![i]
                                  .lecturer!.name!,
                              style: kTextHeme.subtitle1,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      BuildFeCard(
                        child: [
                          Text(
                            'Status Pengajuan Tugas Akhir',
                            style: kTextHeme.headline5?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Palette.primaryVariant),
                          ),
                          Divider(
                            color: Palette.disable,
                          ),
                          Text(
                            'Status Permohonan',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          ChipBuilder(
                            status: acceptedThesis!.proposalStatus!,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Status Berkas',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          ChipBuilder(
                            status: acceptedThesis.krsKhsAcceptment!,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Status SK',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Builder(builder: (context) {
                            String status = '';

                            if (acceptedThesis.examinerSk != null &&
                                acceptedThesis.supervisorSk != null &&
                                acceptedThesis.examinerSk!.isNotEmpty &&
                                acceptedThesis.supervisorSk!.isNotEmpty) {
                              if (acceptedThesis.supervisorSk!.last.statusSkb ==
                                      1 &&
                                  acceptedThesis.examinerSk!.last.statusSkp ==
                                      1) {
                                status = 'Diterima';
                              } else {
                                status = 'Belum_Diproses';
                              }
                            }
                            return ChipBuilder(
                              status:
                                  status.isEmpty ? 'Belum_Diproses' : status,
                            );
                          }),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                if (proposedSeminar != null)
                  ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Text(
                      'Seminar Proposal',
                    ),
                    initiallyExpanded: false,
                    children: [
                      BuildFeCard(
                        child: [
                          Text(
                            'Status Persetujuan Pembimbing',
                            style: kTextHeme.headline5?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Palette.primaryVariant),
                          ),
                          Divider(
                            color: Palette.disable,
                          ),
                          for (int i = 0;
                              i <
                                  proposedSeminar
                                      .supervisorSeminarStatus!.length;
                              i++) ...[
                            Text(
                              'Pembimbing ${proposedSeminar.supervisorSeminarStatus![i].supervisor!.supervisorPosition}',
                              style: kTextHeme.subtitle1?.copyWith(
                                  color: Palette.disable,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              proposedSeminar.supervisorSeminarStatus![i]
                                  .supervisor!.lecturer!.name!,
                              style: kTextHeme.subtitle1,
                            ),
                            ChipBuilder(
                                status: proposedSeminar
                                    .supervisorSeminarStatus![i]
                                    .proposedStatus!),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      BuildFeCard(
                        child: [
                          Text(
                            'Informasi Waktu Seminar',
                            style: kTextHeme.headline5?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Palette.primaryVariant),
                          ),
                          Divider(
                            color: Palette.disable,
                          ),
                          Text(
                            'Hari, Tanggal',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            proposedSeminar.date != null
                                ? ReusableFunctionHelper.datetimeToString(
                                    proposedSeminar.date!)
                                : 'Belum ditentukan',
                            style: kTextHeme.subtitle1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Pukul',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            proposedSeminar.startTime != null
                                ? '${ReusableFunctionHelper.timeFormater(proposedSeminar.startTime!, proposedSeminar.endTime!)} WITA'
                                : 'Belum ditentukan',
                            style: kTextHeme.subtitle1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Tempat (Luring)',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            proposedSeminar.place != null
                                ? '${proposedSeminar.place}'
                                : 'Belum ditentukan',
                            style: kTextHeme.subtitle1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Tempat (Daring)',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            proposedSeminar.link != null
                                ? '${proposedSeminar.link!.trim()}'
                                : 'Belum ditentukan',
                            style: kTextHeme.subtitle1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                if (resultSeminar != null)
                  ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Text(
                      'Seminar Hasil',
                    ),
                    initiallyExpanded: false,
                    children: [
                      BuildFeCard(
                        child: [
                          Text(
                            'Status Persetujuan Pembimbing',
                            style: kTextHeme.headline5?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Palette.primaryVariant),
                          ),
                          Divider(
                            color: Palette.disable,
                          ),
                          for (int i = 0;
                              i < resultSeminar.supervisorSeminarStatus!.length;
                              i++) ...[
                            Text(
                              'Pembimbing ${resultSeminar.supervisorSeminarStatus![i].supervisor!.supervisorPosition}',
                              style: kTextHeme.subtitle1?.copyWith(
                                  color: Palette.disable,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              resultSeminar.supervisorSeminarStatus![i]
                                  .supervisor!.lecturer!.name!,
                              style: kTextHeme.subtitle1,
                            ),
                            ChipBuilder(
                                status: resultSeminar
                                    .supervisorSeminarStatus![i]
                                    .proposedStatus!),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      BuildFeCard(
                        child: [
                          Text(
                            'Informasi Waktu Seminar',
                            style: kTextHeme.headline5?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Palette.primaryVariant),
                          ),
                          Divider(
                            color: Palette.disable,
                          ),
                          Text(
                            'Hari, Tanggal',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            resultSeminar.date != null
                                ? ReusableFunctionHelper.datetimeToString(
                                    resultSeminar.date!)
                                : 'Belum ditentukan',
                            style: kTextHeme.subtitle1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Pukul',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            resultSeminar.startTime != null
                                ? '${ReusableFunctionHelper.timeFormater(resultSeminar.startTime!, resultSeminar.endTime!)} WITA'
                                : 'Belum ditentukan',
                            style: kTextHeme.subtitle1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Tempat (Luring)',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            resultSeminar.place != null
                                ? '${resultSeminar.place}'
                                : 'Belum ditentukan',
                            style: kTextHeme.subtitle1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Tempat (Daring)',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            resultSeminar.link != null
                                ? '${resultSeminar.link!.trim()}'
                                : 'Belum ditentukan',
                            style: kTextHeme.subtitle1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                if (finalExam != null)
                  ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Text(
                      'Ujian Skripsi',
                    ),
                    initiallyExpanded: false,
                    children: [
                      BuildFeCard(
                        child: [
                          Text(
                            'Status Persetujuan Pembimbing',
                            style: kTextHeme.headline5?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Palette.primaryVariant),
                          ),
                          Divider(
                            color: Palette.disable,
                          ),
                          for (int i = 0;
                              i < finalExam.supervisorSeminarStatus!.length;
                              i++) ...[
                            Text(
                              'Pembimbing ${finalExam.supervisorSeminarStatus![i].supervisor!.supervisorPosition}',
                              style: kTextHeme.subtitle1?.copyWith(
                                  color: Palette.disable,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              finalExam.supervisorSeminarStatus![i].supervisor!
                                  .lecturer!.name!,
                              style: kTextHeme.subtitle1,
                            ),
                            ChipBuilder(
                                status: finalExam.supervisorSeminarStatus![i]
                                    .proposedStatus!),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      BuildFeCard(
                        child: [
                          Text(
                            'Informasi Waktu Seminar',
                            style: kTextHeme.headline5?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Palette.primaryVariant),
                          ),
                          Divider(
                            color: Palette.disable,
                          ),
                          Text(
                            'Hari, Tanggal',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            finalExam.date != null
                                ? ReusableFunctionHelper.datetimeToString(
                                    finalExam.date!)
                                : 'Belum ditentukan',
                            style: kTextHeme.subtitle1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Pukul',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            finalExam.startTime != null
                                ? '${ReusableFunctionHelper.timeFormater(finalExam.startTime!, finalExam.endTime!)} WITA'
                                : 'Belum ditentukan',
                            style: kTextHeme.subtitle1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Tempat (Luring)',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            finalExam.place != null
                                ? '${finalExam.place}'
                                : 'Belum ditentukan',
                            style: kTextHeme.subtitle1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Tempat (Daring)',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            finalExam.link != null
                                ? '${finalExam.link!.trim()}'
                                : 'Belum ditentukan',
                            style: kTextHeme.subtitle1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                if (trialExam != null)
                  ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Text(
                      'Ujian Sidang',
                    ),
                    initiallyExpanded: false,
                    children: [
                      BuildFeCard(
                        child: [
                          Text(
                            'Informasi Ujian Sidang',
                            style: kTextHeme.headline5?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Palette.primaryVariant),
                          ),
                          Divider(
                            color: Palette.disable,
                          ),
                          Text(
                            'Status Verifikasi Berkas',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          ChipBuilder(status: trialExam.verificationDocStatus!),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Status Pembuatan Surat',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          ChipBuilder(status: trialExam.validationDocStatus!),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Status Penyerahan Surat/Berkas',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          ChipBuilder(status: trialExam.proposalStatus!),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Status Penandatangan Surat',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          ChipBuilder(
                            status: trialExam.statusTTD == true
                                ? 'Diterima'
                                : 'Belum_Diproses',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
              ],
            ),
          );
        } else {
          return EconLoading();
        }
      },
    );
  }
}

class BuildFeCard extends StatelessWidget {
  final List<Widget> child;
  const BuildFeCard({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: AppSize.getAppWidth(context),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Palette.white,
            boxShadow: [
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
            children: child,
          ),
        ),
        Positioned.fill(
          top: 0,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: Palette.primary,
                ),
                height: 10,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ChipBuilder extends StatelessWidget {
  final String status;
  const ChipBuilder({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    StatusAcceptment statusAcceptment = StatusAcceptment.process;
    switch (status) {
      case 'Ditolak':
        statusAcceptment = StatusAcceptment.reject;
        break;
      case 'Belum_Diproses':
        statusAcceptment = StatusAcceptment.process;
        break;
      case 'Diterima':
        statusAcceptment = StatusAcceptment.accept;
        break;
      default:
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: statusAcceptment == StatusAcceptment.accept
            ? Palette.success
            : statusAcceptment == StatusAcceptment.reject
                ? Palette.danger
                : Palette.secondary,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        '${feStatus[status]}',
        style: kTextHeme.subtitle2?.copyWith(color: Colors.white),
      ),
    );
  }
}
