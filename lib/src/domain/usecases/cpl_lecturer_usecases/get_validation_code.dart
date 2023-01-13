import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';

class GetValidationCode {
  final CplLecturerRepository cplLecturerRepository;

  GetValidationCode({required this.cplLecturerRepository});

  Future<Either<Failure, String?>> execute({required int meetingId}) async {
    return cplLecturerRepository.getValidationCode(meetingId: meetingId);
  }
}
