import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';

abstract class CplStudentRepository {
  Future<Either<Failure, List<ClazzData>?>> getListStudentClass();
  Future<Either<Failure, List<AttendanceData>?>> getListStudentAttendance(
      {required int classId});
}
