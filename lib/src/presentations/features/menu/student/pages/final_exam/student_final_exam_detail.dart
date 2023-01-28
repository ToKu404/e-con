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
    // TODO: implement initState
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
      body: Builder(builder: (context) {
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
                    finalExamObject.status + " " + finalExamObject.title,
                    style: kTextHeme.subtitle2,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(),
                if (proposedSeminar != null)
                  ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Text(
                      'Dosen Pembimbing dan Penguji',
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
                        Divider(),
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
                          Divider(),
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
                          ]
                        ],
                      ),
                    ],
                  ),
                if (proposedSeminar != null ||
                    resultSeminar != null ||
                    finalExam != null)
                  ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 0),
                    title: Text(
                      'Seminar',
                    ),
                    initiallyExpanded: false,
                    children: [
                      if (proposedSeminar != null)
                        BuildFeCard(
                          child: [
                            Text(
                              'Seminar Proposal',
                              style: kTextHeme.headline5?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Palette.primaryVariant),
                            ),
                            Divider(),
                            if (proposedSeminar.date != null) ...[
                              Text(
                                'Hari, Tanggal',
                                style: kTextHeme.subtitle1?.copyWith(
                                    color: Palette.disable,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                ReusableFunctionHelper.datetimeToString(
                                    proposedSeminar.date!),
                                style: kTextHeme.subtitle1,
                              ),
                            ],
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
                              '${proposedSeminar.startTime}-${proposedSeminar.endTime} WITA',
                              style: kTextHeme.subtitle1,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Tempat',
                              style: kTextHeme.subtitle1?.copyWith(
                                  color: Palette.disable,
                                  fontWeight: FontWeight.normal),
                            ),
                            if (proposedSeminar.place != null)
                              Text(
                                'Offline : ${proposedSeminar.place}',
                                style: kTextHeme.subtitle1,
                              ),
                            if (proposedSeminar.link != null)
                              Text(
                                'Online : ${proposedSeminar.link!.split(':')[1].trim()}',
                                style: kTextHeme.subtitle1,
                              ),
                          ],
                        ),
                      SizedBox(
                        height: 16,
                      ),
                      if (resultSeminar != null)
                        BuildFeCard(
                          child: [
                            Text(
                              'Seminar Hasil',
                              style: kTextHeme.headline5?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Palette.primaryVariant),
                            ),
                            Divider(),
                            if (resultSeminar.date != null) ...[
                              Text(
                                'Hari, Tanggal',
                                style: kTextHeme.subtitle1?.copyWith(
                                    color: Palette.disable,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                ReusableFunctionHelper.datetimeToString(
                                    resultSeminar.date!),
                                style: kTextHeme.subtitle1,
                              ),
                            ],
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
                              '${resultSeminar.startTime}-${resultSeminar.endTime} WITA',
                              style: kTextHeme.subtitle1,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Tempat',
                              style: kTextHeme.subtitle1?.copyWith(
                                  color: Palette.disable,
                                  fontWeight: FontWeight.normal),
                            ),
                            if (resultSeminar.place != null)
                              Text(
                                'Offline : ${resultSeminar.place}',
                                style: kTextHeme.subtitle1,
                              ),
                            if (resultSeminar.link != null)
                              Text(
                                'Online : ${resultSeminar.link!.split(':')[1].trim()}',
                                style: kTextHeme.subtitle1,
                              ),
                          ],
                        ),
                      if (finalExam != null)
                        BuildFeCard(
                          child: [
                            Text(
                              'Seminar Hasil',
                              style: kTextHeme.headline5?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Palette.primaryVariant),
                            ),
                            Divider(),
                            if (finalExam.date != null) ...[
                              Text(
                                'Hari, Tanggal',
                                style: kTextHeme.subtitle1?.copyWith(
                                    color: Palette.disable,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                ReusableFunctionHelper.datetimeToString(
                                    finalExam.date!),
                                style: kTextHeme.subtitle1,
                              ),
                            ],
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
                              '${finalExam.startTime}-${finalExam.endTime} WITA',
                              style: kTextHeme.subtitle1,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Tempat',
                              style: kTextHeme.subtitle1?.copyWith(
                                  color: Palette.disable,
                                  fontWeight: FontWeight.normal),
                            ),
                            if (finalExam.place != null)
                              Text(
                                'Offline : ${finalExam.place}',
                                style: kTextHeme.subtitle1,
                              ),
                            if (finalExam.link != null)
                              Text(
                                'Online : ${finalExam.link!.split(':')[1].trim()}',
                                style: kTextHeme.subtitle1,
                              ),
                          ],
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
                      BuildFeCard(child: [
                        Text(
                          'Status Permohonan',
                          style: kTextHeme.subtitle1?.copyWith(
                              color: Palette.disable,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          feStatus[trialExam.proposalStatus!] ?? '-',
                          style: kTextHeme.subtitle1,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Status Validasi Berkas',
                          style: kTextHeme.subtitle1?.copyWith(
                              color: Palette.disable,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          feStatus[trialExam.validationDocStatus!] ?? '-',
                          style: kTextHeme.subtitle1,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Status Verifikasi Berkas',
                          style: kTextHeme.subtitle1?.copyWith(
                              color: Palette.disable,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          feStatus[trialExam.verificationDocStatus!] ?? '-',
                          style: kTextHeme.subtitle1,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        if (trialExam.skDate != null) ...[
                          Text(
                            'Tanggal SK',
                            style: kTextHeme.subtitle1?.copyWith(
                                color: Palette.disable,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            ReusableFunctionHelper.datetimeToString(
                                trialExam.skDate!),
                            style: kTextHeme.subtitle1,
                          ),
                        ],
                      ])
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
    Key? key,
  }) : super(key: key);

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
