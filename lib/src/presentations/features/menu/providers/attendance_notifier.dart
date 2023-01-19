import 'dart:async';

import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/domain/usecases/attendance_usecases/get_list_attendance.dart';
import 'package:e_con/src/domain/usecases/attendance_usecases/set_attendance.dart';
import 'package:e_con/src/domain/usecases/attendance_usecases/set_attendance_by_student.dart';
import 'package:flutter/material.dart';

class AttendanceNotifier extends ChangeNotifier {
  final SetAttendance setAttendanceUsecase;
  final SetAttendanceByStudent setAttendanceByStudentUsecase;
  final GetListAttendance getListAttendanceUsecase;

  AttendanceNotifier({
    required this.setAttendanceUsecase,
    required this.setAttendanceByStudentUsecase,
    required this.getListAttendanceUsecase,
  });

  RequestState _setAttendanceState = RequestState.init;
  RequestState get setAttendanceState => _setAttendanceState;

  Future<void> init() async {
    _setAttendanceState = RequestState.init;
    _setAttendanceByStudentState = RequestState.init;
  }

  Future<void> setAttendance(
      {required int attendanceTypeId,
      required int studentId,
      required int meetingId,
      required int attendanceId}) async {
    _setAttendanceState = RequestState.loading;
    notifyListeners();
    final result = await setAttendanceUsecase.execute(
        attendanceTypeId: attendanceTypeId,
        studentId: studentId,
        meetingId: meetingId,
        attendanceId: attendanceId);

    result.fold((l) {
      _setAttendanceState = RequestState.error;
    }, (r) {
      _setAttendanceState = RequestState.success;
    });
    notifyListeners();
  }

  RequestState _getAttendanceState = RequestState.init;
  RequestState get state => _getAttendanceState;

  List<AttendanceData> _listAttendanceData = [];
  List<AttendanceData> get listAttendanceData => _listAttendanceData;

  Future<void> fetchListAttendance({
    required int meetingId,
    String? query,
  }) async {
    _getAttendanceState = RequestState.loading;
    notifyListeners();
    final result = await getListAttendanceUsecase.execute(
        meetingId: meetingId, query: query);

    result.fold((l) {
      _getAttendanceState = RequestState.error;
    }, (r) {
      _getAttendanceState = RequestState.success;
      _listAttendanceData = r ?? [];
    });
    notifyListeners();
  }

  RequestState _setAttendanceByStudentState = RequestState.init;
  RequestState get setAttendanceByStudentState => _setAttendanceByStudentState;

  Future<void> setAttendanceByStudent(
      {required String validationCode,
      required int studentId,
      required int meetingId}) async {
    _setAttendanceByStudentState = RequestState.loading;
    notifyListeners();
    final result = await setAttendanceByStudentUsecase.execute(
        validationCode: validationCode,
        studentId: studentId,
        meetingId: meetingId);

    result.fold((l) {
      _setAttendanceByStudentState = RequestState.error;
    }, (r) {
      _setAttendanceByStudentState = RequestState.success;
    });
    notifyListeners();
  }
}
