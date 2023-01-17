import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_student_data.dart';
import 'package:flutter/material.dart';

class StudentProfileNotifier extends ChangeNotifier {
  final GetStudentData getStudentDataUsecase;

  StudentProfileNotifier({
    required this.getStudentDataUsecase,
  });

  String _error = '';
  String get error => _error;

  // Login Attribute and Function
  RequestState _state = RequestState.init;
  RequestState get state => _state;

  StudentData? _studentData;
  StudentData? get studentData => _studentData;

  Future<void> getStudentData() async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await getStudentDataUsecase.execute();

    result.fold((l) {
      _error = l.message;
      _state = RequestState.error;
    }, (r) {
      _studentData = r;
      _state = RequestState.success;
    });
    notifyListeners();
  }
}
