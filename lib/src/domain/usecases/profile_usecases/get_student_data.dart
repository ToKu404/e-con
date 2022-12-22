import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:e_con/src/domain/repositories/profile_repository.dart';

class GetStudentData {
  final ProfileRepository profileRepository;

  GetStudentData({required this.profileRepository});

  Future<Either<Failure, StudentData?>> execute() async {
    return profileRepository.getStudentData();
  }
}
