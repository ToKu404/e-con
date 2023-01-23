import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:e_con/src/domain/repositories/final_exam_lecturer_repository.dart';

class GetDetailSeminar {
  final FinalExamLecturerRepository finalExamLecturerRepository;

  GetDetailSeminar({required this.finalExamLecturerRepository});

  Future<Either<Failure, SeminarData?>> execute(int seminarId) async {
    return finalExamLecturerRepository.getDetailSeminar(seminarId);
  }
}
