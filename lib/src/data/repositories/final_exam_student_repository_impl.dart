import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/datasources/final_exam_student_datasource.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:e_con/src/domain/repositories/final_exam_student_repository.dart';

class FinalExamStudentRepositoryImpl implements FinalExamStudentRepository {
  final FinalExamStudentDataSource finalExamStudentDatasource;

  FinalExamStudentRepositoryImpl({required this.finalExamStudentDatasource});

  @override
  Future<Either<Failure, SeminarData?>> getDetailSeminarByStudent() async {
    try {
      final result =
          await finalExamStudentDatasource.getDetailSeminarByStudent();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
