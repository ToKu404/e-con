import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/statistic_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';

abstract class CplLecturerRepository {
  Future<Either<Failure, List<ClazzData>?>> getListCourse();
  Future<Either<Failure, List<MeetingData>?>> getListMeeting(int classId);
  // Future<Either<Failure, List<StudentData>?>> getListStudent(int classId);
  Future<Either<Failure, bool>> createNewMeeting({
    required int classId,
    required String topic,
    required DateTime meetingDate,
  });
  Future<Either<Failure, bool>> deleteMeeting({required int meetingId});
  Future<Either<Failure, bool>> updateMeeting({
    int? classId,
    String? topic,
    DateTime? meetingDate,
    required meetingId,
  });
  Future<Either<Failure, String>> getValidationCode({required int meetingId});
  Future<Either<Failure, bool>> setAttendanceExpiredDate(
      {required DateTime expiredDate, required int meetingId});

  Future<Either<Failure, MeetingData>> getMeetingData({required int meetingId});
  Future<Either<Failure, List<StatisticData>>> getAttendanceStatisticData(
      {required int meetingId});
}
