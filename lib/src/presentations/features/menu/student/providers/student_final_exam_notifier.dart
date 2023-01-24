import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:e_con/src/domain/usecases/final_exam_lecturer_usecases/get_detail_seminar.dart';
import 'package:e_con/src/domain/usecases/final_exam_lecturer_usecases/get_invited_seminars.dart';
import 'package:e_con/src/domain/usecases/final_exam_student_usecases/get_detail_seminar_by_student.dart';
import 'package:flutter/material.dart';

class StudentFinalExamNotifier extends ChangeNotifier {
  final GetDetailSeminarByStudent getDetailSeminarByStudentUsecase;

  StudentFinalExamNotifier({
    required this.getDetailSeminarByStudentUsecase,
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
}
