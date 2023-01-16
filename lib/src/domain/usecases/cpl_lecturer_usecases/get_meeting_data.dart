import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';

class GetMeetingData {
  final CplLecturerRepository cplLecturerRepository;

  GetMeetingData({required this.cplLecturerRepository});

  Future<Either<Failure, MeetingData?>> execute(
      {required int meetingId}) async {
    return cplLecturerRepository.getMeetingData(meetingId: meetingId);
  }
}
