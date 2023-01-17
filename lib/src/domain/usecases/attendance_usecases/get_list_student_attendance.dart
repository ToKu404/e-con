import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/attendance/student_attendance_data.dart';
import 'package:e_con/src/domain/repositories/attendance_repository.dart';

class GetListStudentAttendance {
  final AttendanceRepository attendanceRepository;

  GetListStudentAttendance({required this.attendanceRepository});

  Future<Either<Failure, List<StudentAttendanceData>?>> execute({
    required int classId,
  }) async {
    return attendanceRepository.getListStudentAttendance(
      classId: classId,
    );
  }
}
