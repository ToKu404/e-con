import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';

class UpdateMeeting {
  final CplLecturerRepository cplLecturerRepository;

  UpdateMeeting({required this.cplLecturerRepository});

  Future<Either<Failure, bool>> execute({
    int? classId,
    String? topic,
    DateTime? meetingDate,
    required int meetingId,
  }) async {
    return cplLecturerRepository.updateMeeting(
        classId: classId,
        topic: topic,
        meetingDate: meetingDate,
        meetingId: meetingId);
  }
}
