import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/datasources/attendance_datasource.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/data/models/attendance/student_attendance_data.dart';
import 'package:e_con/src/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceDataSource attendanceDataSource;

  AttendanceRepositoryImpl({required this.attendanceDataSource});

  @override
  Future<Either<Failure, bool>> setAttendance(
      {required int meetingId,
      required int studentId,
      required int attendanceTypeId,
      required int attendanceId}) async {
    try {
      final result = await attendanceDataSource.updateAttendanceStatus(
          meetingId: meetingId,
          studentId: studentId,
          attendanceTypeId: attendanceTypeId,
          attendanceId: attendanceId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AttendanceData>?>> getListAttendance({
    required int meetingId,
    required String? query,
  }) async {
    try {
      final result =
          await attendanceDataSource.fetchAllStudentAttendanceByMeeting(
        meetingId: meetingId,
        query: query,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StudentAttendanceData>>> getListStudentAttendance(
      {required int classId}) async {
    try {
      final result = await attendanceDataSource
          .fetchAllStudentAttendanceByClass(classId: classId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> setAttendanceByStudent(
      {required int meetingId,
      required int studentId,
      required String validationCode}) async {
    try {
      final result = await attendanceDataSource.attendByStudent(
        meetingId: meetingId,
        studentId: studentId,
        validationCode: validationCode,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
