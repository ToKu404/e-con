import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';

class GetListMeeting {
  final CplLecturerRepository cplLecturerRepository;

  GetListMeeting({required this.cplLecturerRepository});

  Future<Either<Failure, List<MeetingData>?>> execute(String id) async {
    return cplLecturerRepository.getListMeeting(id);
  }
}
