import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';

class CreateNewMeeting {
  final CplLecturerRepository cplLecturerRepository;

  CreateNewMeeting({required this.cplLecturerRepository});

  Future<Either<Failure, bool>> execute(
    int classId,
    String topic,
    DateTime meetingDate,
  ) async {
    return cplLecturerRepository.createNewMeeting(
        classId: classId, topic: topic, meetingDate: meetingDate);
  }
}
