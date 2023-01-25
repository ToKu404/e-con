import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/final_exam/fe_proposed_thesis.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:e_con/src/domain/repositories/final_exam_student_repository.dart';

class GetProposedThesis {
  final FinalExamStudentRepository finalExamStudentRepository;

  GetProposedThesis({required this.finalExamStudentRepository});

  Future<Either<Failure, List<FeProposedThesis>>> execute() async {
    return finalExamStudentRepository.getProposedThesis();
  }
}
