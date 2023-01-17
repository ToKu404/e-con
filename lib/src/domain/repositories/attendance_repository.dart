import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/data/models/attendance/student_attendance_data.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, bool>> setAttendance(
      {required int meetingId,
      required int studentId,
      required int attendanceTypeId,
      required int attendanceId});
  Future<Either<Failure, List<AttendanceData>?>> getListAttendance({
    required int meetingId,
    required String? query,
  });
  Future<Either<Failure, List<StudentAttendanceData>>>
      getListStudentAttendance({
    required int classId,
  });
  Future<Either<Failure, bool>> setAttendanceByStudent({
    required int meetingId,
    required int studentId,
    required int attendanceTypeId,
  });
}
