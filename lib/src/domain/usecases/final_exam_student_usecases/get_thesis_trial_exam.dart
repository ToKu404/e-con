import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/final_exam/fe_exam.dart';
import 'package:e_con/src/domain/repositories/final_exam_student_repository.dart';

class GetThesisTrialExam {
  final FinalExamStudentRepository finalExamStudentRepository;

  GetThesisTrialExam({required this.finalExamStudentRepository});

  Future<Either<Failure, FeExam?>> execute() async {
    return finalExamStudentRepository.getThesisTrialExam();
  }
}
