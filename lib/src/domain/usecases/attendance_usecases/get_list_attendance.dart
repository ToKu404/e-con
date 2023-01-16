import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/domain/repositories/attendance_repository.dart';

class GetListAttendance {
  final AttendanceRepository attendanceRepository;

  GetListAttendance({required this.attendanceRepository});

  Future<Either<Failure, List<AttendanceData>?>> execute(
      {required int meetingId}) async {
    return attendanceRepository.getListStudentAttendance(meetingId: meetingId);
  }
}
