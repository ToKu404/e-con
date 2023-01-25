import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/final_exam/fe_proposed_thesis.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:e_con/src/domain/usecases/final_exam_lecturer_usecases/get_detail_seminar.dart';
import 'package:e_con/src/domain/usecases/final_exam_lecturer_usecases/get_invited_seminars.dart';
import 'package:e_con/src/domain/usecases/final_exam_student_usecases/get_detail_seminar_by_student.dart';
import 'package:e_con/src/domain/usecases/final_exam_student_usecases/get_proposed_thesis.dart';
import 'package:flutter/material.dart';

class StudentFinalExamNotifier extends ChangeNotifier {
  final GetDetailSeminarByStudent getDetailSeminarByStudentUsecase;
  final GetProposedThesis getProposedThesisUsecase;

  StudentFinalExamNotifier({
    required this.getDetailSeminarByStudentUsecase,
    required this.getProposedThesisUsecase,
  });

  RequestState _detailState = RequestState.init;
  RequestState get detailState => _detailState;

  SeminarData? _detailSeminar;
  SeminarData? get detailSeminar => _detailSeminar;

  Future<void> getDetailSeminarByStudent() async {
    _detailState = RequestState.loading;
    notifyListeners();
    final result = await getDetailSeminarByStudentUsecase.execute();

    result.fold((l) {
      _detailState = RequestState.error;
    }, (r) {
      _detailSeminar = r;
      _detailState = RequestState.success;
    });
    notifyListeners();
  }

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
}
