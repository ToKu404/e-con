import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/cpl_lecturer/course_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/course_student_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';

abstract class CplLecturerRepository {
  Future<Either<Failure, List<CourseData>?>> getListCourse();
  Future<Either<Failure, List<MeetingData>?>> getListMeeting(String classId);
  Future<Either<Failure, List<CourseStudentData>?>> getListStudent(int classId);
}
