import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';

class DeleteMeeting {
  final CplLecturerRepository cplLecturerRepository;

  DeleteMeeting({required this.cplLecturerRepository});

  Future<Either<Failure, bool>> execute(
    int meetingId,
  ) async {
    return cplLecturerRepository.deleteMeeting(meetingId: meetingId);
  }
}
