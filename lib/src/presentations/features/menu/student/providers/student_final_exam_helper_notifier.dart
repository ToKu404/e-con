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
        print(element.examType);
        if (element.examType == 'Seminar_Hasil' && _resultSeminar == null) {
          _resultSeminar = element;
        } else if (element.examType == 'Seminar_Proposal' &&
            _proposedSeminar == null) {
          _proposedSeminar = element;
        } else if (element.examType == 'Ujian_Skripsi' && _finalExam == null) {
          _finalExam = element;
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
      String message =
          "\"${ReusableFunctionHelper.titleMaker(listSeminar.first.finalExamData!.title!)}\"";
      String title = 'Ujian Sidang';
      final activeTrialExam = listTrialExam;
      String status = '';
      Color color = Palette.secondary;
      if (activeTrialExam.verificationDocStatus == 'Belum_Diproses') {
        status = 'Menunggu Verifikasi Berkas';
      } else if (activeTrialExam.validationDocStatus == 'Belum_Diproses') {
        status = 'Menunggu Validasi Berkas';
      } else if (activeTrialExam.proposalStatus == 'Belum_Diproses' ||
          activeTrialExam.skDate == null) {
        status = 'Menunggu Permohonan Disetujui';
      } else if (activeTrialExam.proposalStatus == 'Diterima') {
        if (DateTime.now().isBefore(activeTrialExam.skDate!)) {
          status = 'Menunggu Jadwal Sidang';
        } else {
          status = 'Selesai';
          color = Palette.success;
        }
      }
      _homeFinalExamDta.add(FinalExamObject(
        title: title,
        status: status,
        color: color,
        message: message,
        onclick: () {
          Navigator.pushNamed(context, AppRoutes.studentDetailFinalExam);
        },
      ));
    } else if (listSeminar.isNotEmpty) {
      String message =
          "\"${ReusableFunctionHelper.titleMaker(listSeminar.first.finalExamData!.title!)}\"";
      String title = '';
      final activeSeminar = listSeminar[listSeminar.length - 1];

      title = seminarType[activeSeminar.examType!]!;
      String status = '';
      Color color = Palette.secondary;
      if (activeSeminar.invitationFiles == null || activeSeminar.date == null) {
        status = 'Pengajuan ${title} sedang diproses';
      } else {
        if (DateTime.now().isBefore(activeSeminar.date!)) {
          status =
              'Menunggu Jadwal ${ReusableFunctionHelper.titleMaker(title)}';
        } else {
          status = 'Selesai Ujian ${ReusableFunctionHelper.titleMaker(title)}';
          color = Palette.success;
        }
      }
      _homeFinalExamDta.add(FinalExamObject(
        title: title,
        status: status,
        color: color,
        message: message,
        onclick: () {
          Navigator.pushNamed(context, AppRoutes.studentDetailFinalExam);
        },
      ));
    } else {
      // Saat kedunya masih diproses
      for (int i = 0; i < listProposedThesis.length; i++) {
        if (listProposedThesis[i].proposalStatus == 'Sedang_Diproses' ||
            listProposedThesis[i].proposalStatus == 'Ditolak') {
          _homeFinalExamDta.add(
            FinalExamObject(
              title: 'Usulan #${i + 1}',
              message: ReusableFunctionHelper.titleMaker(
                  listProposedThesis[i].title ?? ''),
              status: '${feStatus[listProposedThesis[i].proposalStatus!]}',
              onclick: () {},
              color: listProposedThesis[i].proposalStatus == 'Ditolak'
                  ? Palette.danger
                  : Palette.secondary,
            ),
          );
        }
        if (listProposedThesis[i].proposalStatus == 'Diterima') {
          _homeFinalExamDta.clear();
          String status = '';
          Color color = Palette.success;
          if (listProposedThesis[i].skStatus == null) {
            status = 'Menunggu SK Pembimbing dan Penguji';
            color = Palette.secondary;
          } else {
            status = 'Pengajuan Diterima';
          }
          _homeFinalExamDta.add(FinalExamObject(
            title: 'Usulan #${i + 1}',
            message: ReusableFunctionHelper.titleMaker(
                listProposedThesis[i].title ?? ''),
            status: status,
            onclick: () {
              Navigator.pushNamed(context, AppRoutes.studentDetailFinalExam);
            },
            color: color,
          ));
          _state = RequestState.success;
          notifyListeners();
          return;
        }
      }
    }
    _state = RequestState.success;
    notifyListeners();
  }
}
