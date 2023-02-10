import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/domain/usecases/cpl_student_usecases/get_list_student_attendance_history.dart';
import 'package:e_con/src/domain/usecases/cpl_student_usecases/get_list_student_classes.dart';
import 'package:flutter/widgets.dart';

class AttendanceHistoryNotifier extends ChangeNotifier {
  final GetListStudentAttendanceHistory getListStudentAttendanceUsecase;
  final GetListStudentClasses getListStudentClasses;
  AttendanceHistoryNotifier({
    required this.getListStudentAttendanceUsecase,
    required this.getListStudentClasses,
  });

  List<AttendanceData>? _listStudentAttendance;
  List<AttendanceData>? get listStudentAttendance => _listStudentAttendance;

  RequestState _studentAttendanceState = RequestState.init;
  RequestState get studentAttendanceState => _studentAttendanceState;

  Future<void> fetchListStudentAttendance({
    required int classId,
  }) async {
    _studentAttendanceState = RequestState.loading;
    notifyListeners();
    final result =
        await getListStudentAttendanceUsecase.execute(classId: classId);

    result.fold((l) {
      _studentAttendanceState = RequestState.error;
    }, (r) {
      _studentAttendanceState = RequestState.success;
      _listStudentAttendance = r ?? [];
    });
    notifyListeners();
  }

  List<ClazzData>? _listStudentClass;
  List<ClazzData>? get listStudentClass => _listStudentClass;

  RequestState _studentClassesState = RequestState.init;
  RequestState get studentClassesState => _studentClassesState;

  Future<void> fetchListStudentClasses() async {
    _studentClassesState = RequestState.loading;
    notifyListeners();
    final result = await getListStudentClasses.execute();

    result.fold((l) {
      _studentClassesState = RequestState.error;
    }, (r) {
      _studentClassesState = RequestState.success;
      _listStudentClass = r ?? [];
    });
    notifyListeners();
  }
}
