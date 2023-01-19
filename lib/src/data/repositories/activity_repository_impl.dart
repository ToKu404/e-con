import 'package:e_con/core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_con/src/data/datasources/activity_datasource.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/domain/repositories/activity_repository.dart';
import 'package:e_con/src/domain/repositories/cpl_student_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityDataSource activityDataSource;

  ActivityRepositoryImpl({required this.activityDataSource});

  @override
  Future<Either<Failure, List<MeetingData>?>> fetchAllMeetingByDate(
      {required DateTime? date}) async {
    try {
      final result = await activityDataSource.fetchAllMeetingByDate(date: date);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
