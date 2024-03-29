import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/final_exam/fe_exam.dart';
import 'package:e_con/src/data/models/final_exam/fe_proposed_thesis.dart';
import 'package:e_con/src/data/models/final_exam/fe_seminar.dart';
import 'package:e_con/src/domain/usecases/final_exam_student_usecases/get_proposed_thesis.dart';
import 'package:e_con/src/domain/usecases/final_exam_student_usecases/get_seminar_detail.dart';
import 'package:e_con/src/domain/usecases/final_exam_student_usecases/get_thesis_trial_exam.dart';
import 'package:flutter/material.dart';

class StudentFinalExamNotifier extends ChangeNotifier {
  // final GetDetailSeminarByStudent getDetailSeminarByStudentUsecase;
  final GetProposedThesis getProposedThesisUsecase;
  final GetSeminarDetail getSeminarsUsecase;
  final GetThesisTrialExam getThesisTrialExamUsecase;

  StudentFinalExamNotifier({
    // required this.getDetailSeminarByStudentUsecase,
    required this.getProposedThesisUsecase,
    required this.getSeminarsUsecase,
    required this.getThesisTrialExamUsecase,
  });

  // RequestState _detailState = RequestState.init;
  // RequestState get detailState => _detailState;

  // SeminarData? _detailSeminar;
  // SeminarData? get detailSeminar => _detailSeminar;

  // Future<void> getDetailSeminarByStudent() async {
  //   _detailState = RequestState.loading;
  //   notifyListeners();
  //   final result = await getDetailSeminarByStudentUsecase.execute();

  //   result.fold((l) {
  //     _detailState = RequestState.error;
  //   }, (r) {
  //     _detailSeminar = r;
  //     _detailState = RequestState.success;
  //   });
  //   notifyListeners();
  // }

  RequestState _proposedThesisState = RequestState.init;
  RequestState get proposedThesisState => _proposedThesisState;

  List<FeProposedThesis> _listProposedThesis = [];
  List<FeProposedThesis> get listProposedThesis => _listProposedThesis;

  Future<void> getProposedThesis() async {
    _proposedThesisState = RequestState.loading;
    notifyListeners();
    final result = await getProposedThesisUsecase.execute();

    result.fold((l) {
      _proposedThesisState = RequestState.error;
    }, (r) {
      _listProposedThesis = r;
      _proposedThesisState = RequestState.success;
    });
    notifyListeners();
  }

  RequestState _seminarsState = RequestState.init;
  RequestState get seminarsState => _seminarsState;

  List<FeSeminar> _listSeminar = [];
  List<FeSeminar> get listSeminar => _listSeminar;

  Future<void> getSeminars() async {
    _seminarsState = RequestState.loading;
    notifyListeners();
    final result = await getSeminarsUsecase.execute();

    result.fold((l) {
      _seminarsState = RequestState.error;
    }, (r) {
      _listSeminar = r;
      _seminarsState = RequestState.success;
    });
    notifyListeners();
  }

  RequestState _trialExamState = RequestState.init;
  RequestState get trialExamState => _trialExamState;

  FeExam? _thesisTrialExam;
  FeExam? get thesisTrialExam => _thesisTrialExam;

  Future<void> getThesisTrialExam() async {
    _trialExamState = RequestState.loading;
    notifyListeners();
    final result = await getThesisTrialExamUsecase.execute();

    result.fold((l) {
      _trialExamState = RequestState.error;
    }, (r) {
      _thesisTrialExam = r;
      _trialExamState = RequestState.success;
    });
    notifyListeners();
  }
}
