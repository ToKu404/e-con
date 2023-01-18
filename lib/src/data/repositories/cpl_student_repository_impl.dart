import 'package:e_con/core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_con/src/data/datasources/cpl_student_datasource.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/domain/repositories/cpl_student_repository.dart';

class CplStudentRepositoryImpl implements CplStudentRepository {
  final CplStudentDataSource cplStudentLecturer;

  CplStudentRepositoryImpl({required this.cplStudentLecturer});

  @override
  Future<Either<Failure, List<AttendanceData>>> getListStudentAttendance(
      {required int classId}) async {
    try {
      final result =
          await cplStudentLecturer.getListStudentAttendance(classId: classId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ClazzData>>> getListStudentClass() async {
    try {
      final result = await cplStudentLecturer.getListStudentClass();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
