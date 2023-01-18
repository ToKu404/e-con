import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/domain/repositories/cpl_student_repository.dart';

class GetListStudentClasses {
  final CplStudentRepository cplStudentRepository;

  GetListStudentClasses({required this.cplStudentRepository});

  Future<Either<Failure, List<ClazzData>?>> execute() async {
    return cplStudentRepository.getListStudentClass();
  }
}
