import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/cpl_lecturer/course_student_data.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_list_student.dart';
import 'package:flutter/material.dart';

class CourseStudentNotifier extends ChangeNotifier {
  final GetListStudent getListStudentUsecase;

  CourseStudentNotifier({
    required this.getListStudentUsecase,
  });

  String _error = '';
  String get error => _error;

  RequestState _state = RequestState.init;
  RequestState get state => _state;

  List<CourseStudentData>? _listStudent;
  List<CourseStudentData>? get listStudent => _listStudent;

  Future<void> getListStudent(int classId) async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await getListStudentUsecase.execute(classId);

    result.fold((l) {
      _error = l.message;
      _state = RequestState.error;
    }, (r) {
      _listStudent = r;
      _state = RequestState.success;
    });
    notifyListeners();
  }
}
