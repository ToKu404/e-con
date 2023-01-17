import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:e_con/src/domain/repositories/cpl_lecturer_repository.dart';

class GetListStudent {
  final CplLecturerRepository cplLecturerRepository;

  GetListStudent({required this.cplLecturerRepository});

  Future<Either<Failure, List<StudentData>?>> execute(int id) async {
    return cplLecturerRepository.getListStudent(id);
  }
}
