import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/datasources/cpl_lecturer_datasource.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/course_student_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';

class CplLecturerRepositoryImpl implements CplLecturerRepository {
  final CplLecturerDataSource cplLecturerDataSource;

  CplLecturerRepositoryImpl({required this.cplLecturerDataSource});

  @override
  Future<Either<Failure, List<ClazzData>?>> getListCourse() async {
    try {
      final result = await cplLecturerDataSource.getListClazz();
      return Right(result.listClazz);
    } on UnauthenticateException {
      return const Left(ServerFailure('Username atau Password salah'));
    } on UserNotFoundException {
      return const Left(ServerFailure('User tidak ditemukan'));
    } on AuthException {
      return const Left(ServerFailure('Proses login gagal'));
    }
  }

  @override
  Future<Either<Failure, List<MeetingData>?>> getListMeeting(
      int classId) async {
    try {
      final result = await cplLecturerDataSource.getListMeeting(classId);
      return Right(result);
    } on UnauthenticateException {
      return const Left(AuthFailure('Masalah auth'));
    } on AuthException {
      return const Left(AuthFailure('Masalah auth'));
    }
  }

  @override
  Future<Either<Failure, List<CourseStudentData>?>> getListStudent(
      int classId) async {
    try {
      final result = await cplLecturerDataSource.getListStudent(classId);
      return Right(result);
    } on UnauthenticateException {
      return const Left(ServerFailure('Masalah auth'));
    } on AuthException {
      return const Left(ServerFailure('Masalah auth'));
    }
  }

  @override
  Future<Either<Failure, bool>> createNewMeeting(
      {required int classId,
      required String topic,
      required DateTime meetingDate}) async {
    try {
      final result = await cplLecturerDataSource.createNewMeeting(
          classId: classId, topic: topic, meetingDate: meetingDate);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Masalah Server'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMeeting({required int meetingId}) async {
    try {
      final result =
          await cplLecturerDataSource.deleteMeeting(meetingId: meetingId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Masalah Server'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateMeeting(
      {int? classId,
      String? topic,
      DateTime? meetingDate,
      required meetingId}) async {
    try {
      final result = await cplLecturerDataSource.updateMeeting(
        classId: classId,
        topic: topic,
        meetingDate: meetingDate,
        meetingId: meetingId,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Masalah Server'));
    }
  }
}
