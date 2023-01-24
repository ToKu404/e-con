import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';

abstract class FinalExamStudentRepository {
  Future<Either<Failure, SeminarData?>> getDetailSeminarByStudent();
}
