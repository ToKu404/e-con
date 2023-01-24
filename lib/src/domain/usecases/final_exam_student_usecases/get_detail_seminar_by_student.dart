import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:e_con/src/domain/repositories/final_exam_student_repository.dart';

class GetDetailSeminarByStudent {
  final FinalExamStudentRepository finalExamStudentRepository;

  GetDetailSeminarByStudent({required this.finalExamStudentRepository});

  Future<Either<Failure, SeminarData?>> execute() async {
    return finalExamStudentRepository.getDetailSeminarByStudent();
  }
}
