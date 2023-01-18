import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/datasources/cpl_lecturer_datasource.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/statistic_data.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
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
    } on DataNotFoundException {
      return Left(EmptyFailure('Dosen Belum Memiliki Kelas'));
    }
  }

  @override
  Future<Either<Failure, List<MeetingData>?>> getListMeeting(
      int classId) async {
    try {
      final result = await cplLecturerDataSource.getListMeeting(classId);
      return Right(result);
    } on DataNotFoundException {
      return Left(EmptyFailure('Silahkan buat pertemuan terlebih dahulu'));
    }
  }

  @override
  Future<Either<Failure, List<StudentData>?>> getListStudent(
      int classId) async {
    try {
      final result = await cplLecturerDataSource.getListStudent(classId);
      return Right(result);
    } on DataNotFoundException {
      return Left(EmptyFailure('Belum ada peserta matakuliah ini'));
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

  @override
  Future<Either<Failure, String>> getValidationCode(
      {required int meetingId}) async {
    try {
      final result =
          await cplLecturerDataSource.getValidationCode(meetingId: meetingId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Terdapat Masalah'));
    }
  }

  @override
  Future<Either<Failure, bool>> setAttendanceExpiredDate(
      {required DateTime expiredDate, required int meetingId}) async {
    try {
      final result = await cplLecturerDataSource.setAttendanceExpiredDate(
          expiredDate: expiredDate, meetingId: meetingId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MeetingData>> getMeetingData(
      {required int meetingId}) async {
    try {
      final result =
          await cplLecturerDataSource.getMeetingData(meetingId: meetingId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StatisticData>>> getAttendanceStatisticData(
      {required int meetingId}) async {
    try {
      final result = await cplLecturerDataSource.getAttendanceStatisticData(
          meetingId: meetingId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
