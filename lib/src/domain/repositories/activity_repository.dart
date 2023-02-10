import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';

abstract class ActivityRepository {
  Future<Either<Failure, List<MeetingData>?>> fetchAllMeetingByDate(
      {required DateTime? date});
}
