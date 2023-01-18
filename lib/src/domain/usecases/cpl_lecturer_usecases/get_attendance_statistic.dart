import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/cpl_lecturer/statistic_data.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';

class GetAttendanceStatistic {
  final CplLecturerRepository cplLecturerRepository;

  GetAttendanceStatistic({required this.cplLecturerRepository});

  Future<Either<Failure, List<StatisticData>?>> execute(int meetingId) async {
    return cplLecturerRepository.getAttendanceStatisticData(
        meetingId: meetingId);
  }
}
