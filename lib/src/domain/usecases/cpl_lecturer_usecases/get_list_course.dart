import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/cpl_lecturer/course_data.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';

class GetListCourse {
  final CplLecturerRepository cplLecturerRepository;

  GetListCourse({required this.cplLecturerRepository});

  Future<Either<Failure, List<CourseData>?>> execute() async {
    return cplLecturerRepository.getListCourse();
  }
}
