import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/helpers/final_exam_helper.dart';
import 'package:e_con/core/helpers/reusable_function_helper.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/final_exam/fe_exam.dart';
import 'package:e_con/src/data/models/final_exam/fe_proposed_thesis.dart';
import 'package:e_con/src/data/models/final_exam/fe_seminar.dart';
import 'package:flutter/widgets.dart';

class StudentFinalExamHelperNotifier extends ChangeNotifier {
  RequestState _state = RequestState.init;
  RequestState get state => _state;

  RequestState _proposedThesisState = RequestState.init;
  RequestState get proposedThesisState => _proposedThesisState;

  RequestState _seminarState = RequestState.init;
  RequestState get seminarState => _seminarState;

  RequestState _trialExamState = RequestState.init;
  RequestState get trialExamState => _trialExamState;

  final List<FinalExamObject> _homeFinalExamDta = [];
  List<FinalExamObject> get homeFinalExamDta => _homeFinalExamDta;

  FeProposedThesis? _acceptedThesis;
  FeSeminar? _resultSeminar;
  FeSeminar? _proposedSeminar;
  FeSeminar? _finalExam;
  FeExam? _trialExam;

  FeProposedThesis? get acceptedThesis => _acceptedThesis;
  FeSeminar? get resultSeminar => _resultSeminar;
  FeSeminar? get proposedSeminar => _proposedSeminar;
  FeSeminar? get finalExam => _finalExam;
  FeExam? get trialExam => _trialExam;

  void acceptedThesisInit(
      {required List<FeProposedThesis> listProposedThesis,
      required BuildContext context}) {
    _proposedThesisState = RequestState.loading;
    notifyListeners();
    if (listProposedThesis.isNotEmpty) {
      for (var element in listProposedThesis) {
        if (element.proposalStatus == 'Diterima') {
          _acceptedThesis = element;
          _proposedThesisState = RequestState.success;
          notifyListeners();
          return;
        }
      }
    }
    _proposedThesisState = RequestState.success;
    notifyListeners();
  }

  void seminarInit(
      {required List<FeSeminar> listSeminar, required BuildContext context}) {
    _seminarState = RequestState.loading;
    notifyListeners();
    if (listSeminar.isNotEmpty) {
      for (var element in listSeminar) {
        print("exam ${element.examType}");
        if (element.examType == 'Ujian_Skripsi') {
          _finalExam = element;
        } else if (element.examType == 'Seminar_Hasil') {
          _resultSeminar = element;
        } else if (element.examType == 'Seminar_Proposal') {
          _proposedSeminar = element;
        }
      }
    }
    _seminarState = RequestState.success;
    notifyListeners();
  }

  void trialExamInit({required FeExam? exam, required BuildContext context}) {
    _trialExamState = RequestState.loading;
    notifyListeners();
    _trialExam = exam;
    _trialExamState = RequestState.success;
    notifyListeners();
  }

  void init(
      {required List<FeProposedThesis> listProposedThesis,
      required List<FeSeminar> listSeminar,
      required FeExam? listTrialExam,
      required BuildContext context}) {
    _state = RequestState.loading;
    notifyListeners();
    homeFinalExamDta.clear();

    if (listTrialExam != null) {
      //status permohonan
      StatusAcceptment statusAcceptment = StatusAcceptment.process;
      String title = 'Ujian Sidang';
      String status = "Permohonan Ujian Sidang Dibuat";
      String subtitle =
          "\"${ReusableFunctionHelper.titleMaker(listProposedThesis.first.title!)}\"";

      final activeTrialExam = listTrialExam;

      ///(1)
      if (activeTrialExam.verificationDocStatus != null) {
        switch (activeTrialExam.verificationDocStatus) {
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
        status =
            'Verifikasi Berkas ${feStatus[activeTrialExam.verificationDocStatus]}';

        if (statusAcceptment == StatusAcceptment.accept) {
          ///(2)
          switch (activeTrialExam.validationDocStatus) {
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
          status =
              'Pembuatan Surat ${feStatus[activeTrialExam.verificationDocStatus]}';

          if (statusAcceptment == StatusAcceptment.accept) {
            ///(3)
            switch (activeTrialExam.proposalStatus) {
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
            status =
                'Penyerahan Surat/Berkas ${feStatus[activeTrialExam.verificationDocStatus]}';

            if (statusAcceptment == StatusAcceptment.accept) {
              if (activeTrialExam.statusTTD!) {
                statusAcceptment = StatusAcceptment.accept;
                status = 'Surat Diterima';
              } else {
                statusAcceptment = StatusAcceptment.reject;
                status = 'Penandatangan Surat Diproses';
              }
            }
          }
        }
      }

      _homeFinalExamDta.add(FinalExamObject(
        title: title,
        subtitle: subtitle,
        status: status,
        onclick: () {
          Navigator.pushNamed(context, AppRoutes.studentDetailFinalExam);
        },
        color: statusAcceptment == StatusAcceptment.accept
            ? Palette.success
            : statusAcceptment == StatusAcceptment.reject
                ? Palette.danger
                : Palette.secondary,
      ));
      _state = RequestState.success;
      notifyListeners();
    } else if (listSeminar.isNotEmpty) {
      //status permohonan
      StatusAcceptment statusAcceptment = StatusAcceptment.process;
      final activeSeminar = listSeminar[listSeminar.length - 1];
      String title = seminarType[activeSeminar.examType!]!;
      String status = "Permohonan Seminar";
      String subtitle =
          "\"${ReusableFunctionHelper.titleMaker(listSeminar.first.finalExamData!.title!)}\"";

      /// (1) Permohonan Seminar
      if (activeSeminar.supervisorSeminarStatus != null &&
          activeSeminar.supervisorSeminarStatus!.isNotEmpty) {
        bool isReject = false;
        bool isProcess = false;
        for (final supervisorSeminarStatus
            in activeSeminar.supervisorSeminarStatus!) {
          switch (supervisorSeminarStatus.proposedStatus) {
            case 'Ditolak':
              statusAcceptment = StatusAcceptment.reject;
              status = 'Permohonan Seminar Ditolak';
              isReject = true;
              break;
            case 'Belum_Diproses':
              statusAcceptment = StatusAcceptment.process;
              isProcess = true;
              status = 'Permohonan Seminar Belum Diproses';
              break;

            default:
          }
          if (isProcess || isReject) {
            break;
          }
        }
        if (!isProcess && !isReject) {
          statusAcceptment = StatusAcceptment.accept;
          status = 'Permohonan Seminar Disetujui';

          /// (3) Penetapan Waktu Seminar
          if (activeSeminar.date == null) {
            statusAcceptment = StatusAcceptment.process;
            status = 'Penetapan Waktu Seminar Diproses';
          }
        }
      }

      /// (3)
      if (activeSeminar.date != null) {
        statusAcceptment = StatusAcceptment.process;
        status = 'Menunggu Pembuatan Dokumen Seminar';
      }

      /// (4)
      if (activeSeminar.newsFiles != null &&
          activeSeminar.invitationFiles != null &&
          activeSeminar.availabilityFiles != null &&
          activeSeminar.valueStatementFiles != null) {
        statusAcceptment = StatusAcceptment.accept;
        status = 'Dokumen Seminar Diterima';
      }

      _homeFinalExamDta.add(FinalExamObject(
        title: title,
        subtitle: subtitle,
        status: status,
        onclick: () {
          Navigator.pushNamed(context, AppRoutes.studentDetailFinalExam);
        },
        color: statusAcceptment == StatusAcceptment.accept
            ? Palette.success
            : statusAcceptment == StatusAcceptment.reject
                ? Palette.danger
                : Palette.secondary,
      ));
      _state = RequestState.success;
      notifyListeners();
      return;
    } else {
      // Saat kedunya masih diproses
      for (int i = 0; i < listProposedThesis.length;) {
        //status permohonan
        StatusAcceptment statusAcceptment = StatusAcceptment.process;
        String title = '';
        String status = '';
        String subtitle = '';

        /// (1) Pengusulan Judul
        ///
        switch (listProposedThesis[i].proposalStatus) {
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
        title = 'Usulan #${i + 1}';
        subtitle = ReusableFunctionHelper.titleMaker(
            listProposedThesis[i].title ?? '');
        status =
            'Pengusulan Judul ${feStatus[listProposedThesis[i].proposalStatus!]}';

        if (statusAcceptment == StatusAcceptment.accept) {
          /// (2) Verifikasi Dokumen
          switch (listProposedThesis[i].krsKhsAcceptment) {
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
          status =
              'Status Verifikasi KRS dan KHS ${feStatus[listProposedThesis[i].krsKhsAcceptment!]}';

          if (statusAcceptment == StatusAcceptment.accept) {
            /// (3) Penyusunan Tim Seminar
            if (listProposedThesis[i].listSupervisor == null ||
                listProposedThesis[i].listExaminer == null) {
              if (listProposedThesis[i].listSupervisor!.isEmpty ||
                  listProposedThesis[i].listExaminer!.isEmpty) {
                status = 'Penyusunan Tim Seminar';
                statusAcceptment = StatusAcceptment.process;
              }
            }
          }
        }

        /// (4) Penandatangan SK
        if (listProposedThesis[i].examinerSk != null &&
            listProposedThesis[i].supervisorSk != null) {
          if (listProposedThesis[i].supervisorSk!.last.statusSkb ==
                  'Diterima' ||
              listProposedThesis[i].examinerSk!.last.statusSkp == 'Diterima') {
            status = 'Penandatangan SK Diterima';
            statusAcceptment = StatusAcceptment.accept;
          }
          if (listProposedThesis[i].supervisorSk!.last.statusSkb ==
                  'Belum_Diproses' ||
              listProposedThesis[i].examinerSk!.last.statusSkp ==
                  'Belum_Diproses') {
            status = 'Penandatangan SK Sedang Diproses';
            statusAcceptment = StatusAcceptment.process;
          }
          if (listProposedThesis[i].examinerSk!.last.statusSkp == 'Ditolak') {
            status = 'Penandatangan SK Penguji Ditolak';
            statusAcceptment = StatusAcceptment.reject;
          }
          if (listProposedThesis[i].supervisorSk!.last.statusSkb == 'Ditolak') {
            status = 'Penandatangan SK Pembimbing Ditolak';
            statusAcceptment = StatusAcceptment.reject;
          }
        }
        _homeFinalExamDta.add(FinalExamObject(
          title: title,
          subtitle: subtitle,
          status: status,
          onclick: () {
            Navigator.pushNamed(context, AppRoutes.studentDetailFinalExam);
          },
          color: statusAcceptment == StatusAcceptment.accept
              ? Palette.success
              : statusAcceptment == StatusAcceptment.reject
                  ? Palette.danger
                  : Palette.secondary,
        ));
        _state = RequestState.success;
        notifyListeners();
        return;
      }
    }
    _state = RequestState.success;
    notifyListeners();
  }
}

enum StatusAcceptment {
  accept,
  process,
  reject,
}
