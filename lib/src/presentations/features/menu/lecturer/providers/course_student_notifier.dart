import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/attendance/student_attendance_data.dart';
import 'package:e_con/src/domain/usecases/attendance_usecases/get_list_student_attendance.dart';
import 'package:flutter/material.dart';

class CourseStudentNotifier extends ChangeNotifier {
  final GetListStudentAttendance getListStudentUsecase;

  CourseStudentNotifier({
    required this.getListStudentUsecase,
  });

  String _error = '';
  String get error => _error;

  RequestState _state = RequestState.init;
  RequestState get state => _state;

  List<StudentAttendanceData>? _listStudent;
  List<StudentAttendanceData>? get listStudent => _listStudent;

  Future<void> getListStudent(int classId) async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await getListStudentUsecase.execute(classId: classId);

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
