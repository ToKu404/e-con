import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/final_exam/fe_seminar.dart';
import 'package:e_con/src/domain/repositories/final_exam_student_repository.dart';

class GetSeminarDetail {
  final FinalExamStudentRepository finalExamStudentRepository;

  GetSeminarDetail({required this.finalExamStudentRepository});

  Future<Either<Failure, List<FeSeminar>>> execute() async {
    return finalExamStudentRepository.getSeminarDetail();
  }
}
