import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/datasources/attendance_datasource.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceDataSource attendanceDataSource;

  AttendanceRepositoryImpl({required this.attendanceDataSource});

  @override
  Future<Either<Failure, bool>> setAttendance(
      {required int meetingId,
      required int studentId,
      required int attendanceTypeId}) async {
    try {
      final result = await attendanceDataSource.setAttendance(
          meetingId: meetingId,
          studentId: studentId,
          attendanceTypeId: attendanceTypeId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AttendanceData>?>> getListStudentAttendance(
      {required int meetingId}) async {
    try {
      final result = await attendanceDataSource.getListAttendance(
        meetingId: meetingId,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
