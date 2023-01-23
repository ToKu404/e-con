import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/datasources/final_exam_lecturer_datasource.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:e_con/src/domain/repositories/final_exam_lecturer_repository.dart';

class FinalExamLecturerRepositoryImpl implements FinalExamLecturerRepository {
  final FinalExamLecturerDataSource finalExamLecturerDataSource;

  FinalExamLecturerRepositoryImpl({required this.finalExamLecturerDataSource});

  @override
  Future<Either<Failure, List<SeminarData>>> getInvitedSeminars() async {
    try {
      final result = await finalExamLecturerDataSource.getInvitedSeminars();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SeminarData>> getDetailSeminar(int seminarId) async {
    try {
      final result =
          await finalExamLecturerDataSource.getDetailSeminar(seminarId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
