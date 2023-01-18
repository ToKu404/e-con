import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/domain/repositories/attendance_repository.dart';

class SetAttendanceByStudent {
  final AttendanceRepository attendanceRepository;

  SetAttendanceByStudent({required this.attendanceRepository});

  Future<Either<Failure, bool>> execute({
    required String validationCode,
    required int studentId,
    required int meetingId,
  }) async {
    return attendanceRepository.setAttendanceByStudent(
      validationCode: validationCode,
      meetingId: meetingId,
      studentId: studentId,
    );
  }
}
