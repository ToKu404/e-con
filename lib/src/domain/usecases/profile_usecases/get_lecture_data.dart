import 'package:dartz/dartz.dart';
import 'package:e_con/core/common/failure.dart';
import 'package:e_con/src/data/models/profile/lecture_data.dart';
import 'package:e_con/src/domain/repositories/profile_repository.dart';

class GetLectureData {
  final ProfileRepository profileRepository;

  GetLectureData({required this.profileRepository});

  Future<Either<Failure, LectureData?>> execute() async {
    return profileRepository.getLectureData();
  }
}
