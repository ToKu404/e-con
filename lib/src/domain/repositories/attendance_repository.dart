import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, bool>> setAttendance(
      {required int meetingId,
      required int studentId,
      required int attendanceTypeId});
  Future<Either<Failure, List<AttendanceData>?>> getListStudentAttendance(
      {required int meetingId});
}
