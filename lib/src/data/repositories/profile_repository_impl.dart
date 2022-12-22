import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/src/data/datasources/profile_datasource.dart';
import 'package:e_con/src/data/models/profile/lecture_data.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_con/src/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource profileDataSource;

  ProfileRepositoryImpl({required this.profileDataSource});

  @override
  Future<Either<Failure, StudentData?>> getStudentData() async {
    try {
      final result = await profileDataSource.getStudentData();
      return Right(result);
    } on LocalDatabaseException {
      return const Left(AuthFailure('Terdapat masalah pada data user'));
    } on UserNotFoundException {
      return const Left(AuthFailure('Data user tidak ditemukan'));
    } on AuthException {
      return const Left(AuthFailure('Proses login bermasalah'));
    }
  }

  @override
  Future<Either<Failure, LectureData?>> getLectureData() async {
    try {
      final result = await profileDataSource.getLectureData();
      return Right(result);
    } on LocalDatabaseException {
      return const Left(AuthFailure('Terdapat masalah pada data user'));
    } on UserNotFoundException {
      return const Left(AuthFailure('Data user tidak ditemukan'));
    } on AuthException {
      return const Left(AuthFailure('Proses login bermasalah'));
    }
  }
}
