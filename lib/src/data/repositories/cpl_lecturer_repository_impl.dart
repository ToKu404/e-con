import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/datasources/cpl_lecturer_datasource.dart';
import 'package:e_con/src/data/models/cpl_lecturer/course_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/course_student_data.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';

class CplLecturerRepositoryImpl implements CplLecturerRepository {
  final CplLecturerDataSource cplLecturerDataSource;

  CplLecturerRepositoryImpl({required this.cplLecturerDataSource});

  @override
  Future<Either<Failure, List<CourseData>?>> getListCourse() async {
    try {
      final result = await cplLecturerDataSource.getListCourse();
      return Right(result.listCourse);
    } on UnauthenticateException {
      return const Left(AuthFailure('Username atau Password salah'));
    } on UserNotFoundException {
      return const Left(AuthFailure('User tidak ditemukan'));
    } on AuthException {
      return const Left(AuthFailure('Proses login gagal'));
    }
  }

  @override
  Future<Either<Failure, List<MeetingData>?>> getListMeeting(
      String classId) async {
    try {
      final result = await cplLecturerDataSource.getListMeeting(classId);
      return Right(result);
    } on UnauthenticateException {
      return const Left(AuthFailure('Username atau Password salah'));
    } on UserNotFoundException {
      return const Left(AuthFailure('User tidak ditemukan'));
    } on AuthException {
      return const Left(AuthFailure('Proses login gagal'));
    }
  }

  @override
  Future<Either<Failure, List<CourseStudentData>?>> getListStudent(
      int classId) async {
    try {
      final result = await cplLecturerDataSource.getListStudent(classId);
      return Right(result);
    } on UnauthenticateException {
      return const Left(AuthFailure('Username atau Password salah'));
    } on UserNotFoundException {
      return const Left(AuthFailure('User tidak ditemukan'));
    } on AuthException {
      return const Left(AuthFailure('Proses login gagal'));
    }
  }
}
