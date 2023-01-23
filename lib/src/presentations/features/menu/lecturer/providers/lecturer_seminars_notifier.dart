import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:e_con/src/domain/usecases/final_exam_lecturer_usecases/get_detail_seminar.dart';
import 'package:e_con/src/domain/usecases/final_exam_lecturer_usecases/get_invited_seminars.dart';
import 'package:flutter/material.dart';

class LecturerSeminarNotifier extends ChangeNotifier {
  final GetInvitedSeminars getInvitedSeminarsUsecases;
  final GetDetailSeminar getDetailSeminarUsecase;

  LecturerSeminarNotifier({
    required this.getInvitedSeminarsUsecases,
    required this.getDetailSeminarUsecase,
  }) {
    fetchInvitedSeminars();
  }

  String _error = '';
  String get error => _error;

  RequestState _state = RequestState.init;
  RequestState get state => _state;

  List<SeminarData> _seminars = [];
  List<SeminarData> get seminars => _seminars;

  Future<void> fetchInvitedSeminars() async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await getInvitedSeminarsUsecases.execute();

    result.fold((l) {
      _error = l.message;
      _state = RequestState.error;
    }, (r) {
      _seminars = r ?? [];
      _state = RequestState.success;
    });
    notifyListeners();
  }

  RequestState _detailState = RequestState.init;
  RequestState get detailState => _detailState;

  SeminarData? _detailSeminar;
  SeminarData? get detailSeminar => _detailSeminar;

  Future<void> getDetailSeminar(int seminarId) async {
    _detailState = RequestState.loading;
    notifyListeners();
    final result = await getDetailSeminarUsecase.execute(seminarId);

    result.fold((l) {
      _error = l.message;
      _detailState = RequestState.error;
    }, (r) {
      _detailSeminar = r;
      _detailState = RequestState.success;
    });
    notifyListeners();
  }
}
