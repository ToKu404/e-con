import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/domain/repositories/attendance_repository.dart';

class SetAttendance {
  final AttendanceRepository attendanceRepository;

  SetAttendance({required this.attendanceRepository});

  Future<Either<Failure, bool>> execute(
      {required int attendanceTypeId,
      required int studentId,
      required int meetingId,
      required int attendanceId}) async {
    return attendanceRepository.setAttendance(
      attendanceTypeId: attendanceTypeId,
      meetingId: meetingId,
      studentId: studentId,
      attendanceId: attendanceId,
    );
  }
}
