import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/domain/repositories/activity_repository.dart';

class GetAllMeetingByDate {
  final ActivityRepository activityRepository;

  GetAllMeetingByDate({required this.activityRepository});

  Future<Either<Failure, List<MeetingData>?>> execute({
    required DateTime? dateTime,
  }) async {
    return activityRepository.fetchAllMeetingByDate(date: dateTime);
  }
}
