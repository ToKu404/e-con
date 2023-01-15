import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';

class SetAttendanceExpiredDate {
  final CplLecturerRepository cplLecturerRepository;

  SetAttendanceExpiredDate({required this.cplLecturerRepository});

  Future<Either<Failure, bool>> execute(
      int meetingId, DateTime expiredDate) async {
    return cplLecturerRepository.setAttendanceExpiredDate(
        meetingId: meetingId, expiredDate: expiredDate);
  }
}
