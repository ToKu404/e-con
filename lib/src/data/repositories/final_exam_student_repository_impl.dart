import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/datasources/final_exam_student_datasource.dart';
import 'package:e_con/src/data/models/final_exam/fe_exam.dart';
import 'package:e_con/src/data/models/final_exam/fe_proposed_thesis.dart';
import 'package:e_con/src/data/models/final_exam/fe_seminar.dart';
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

  @override
  Future<Either<Failure, List<FeProposedThesis>>> getProposedThesis() async {
    try {
      final result = await finalExamStudentDatasource.getProposedThesis();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FeSeminar>>> getSeminarDetail() async {
    try {
      final result = await finalExamStudentDatasource.getSeminarDetail();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FeExam?>> getThesisTrialExam() async {
    try {
      final result = await finalExamStudentDatasource.getThesisTrialExam();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
