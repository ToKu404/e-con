import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/domain/repositories/cpl_student_repository.dart';

class GetListStudentAttendanceHistory {
  final CplStudentRepository cplStudentRepository;

  GetListStudentAttendanceHistory({required this.cplStudentRepository});

  Future<Either<Failure, List<AttendanceData>?>> execute(
      {required int classId}) async {
    return cplStudentRepository.getListStudentAttendance(classId: classId);
  }
}
