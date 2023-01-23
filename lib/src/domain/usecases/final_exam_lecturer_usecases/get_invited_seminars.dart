import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:e_con/src/domain/repositories/final_exam_lecturer_repository.dart';

class GetInvitedSeminars {
  final FinalExamLecturerRepository finalExamLecturerRepository;

  GetInvitedSeminars({required this.finalExamLecturerRepository});

  Future<Either<Failure, List<SeminarData>?>> execute() async {
    return finalExamLecturerRepository.getInvitedSeminars();
  }
}
