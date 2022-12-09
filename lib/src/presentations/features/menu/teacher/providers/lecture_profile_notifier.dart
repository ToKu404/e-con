import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/profile/lecture_data.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_lecture_data.dart';
import 'package:flutter/material.dart';

class LectureProfileNotifier extends ChangeNotifier {
  final GetLectureData getLectureDataUsecase;

  LectureProfileNotifier({
    required this.getLectureDataUsecase,
  }) {
    getStudentData();
  }

  String _error = '';
  String get error => _error;

  // Login Attribute and Function
  RequestState _state = RequestState.init;
  RequestState get state => _state;

  LectureData? _lectureData;
  LectureData? get lectureData => _lectureData;

  Future<void> getStudentData() async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await getLectureDataUsecase.execute();

    result.fold((l) {
      _error = l.message;
      _state = RequestState.error;
    }, (r) {
      _lectureData = r;
      _state = RequestState.success;
    });
    notifyListeners();
  }
}
