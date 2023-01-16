import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/domain/repositories/profile_repository.dart';

class GetProfilePicture {
  final ProfileRepository profileRepository;

  GetProfilePicture({required this.profileRepository});

  Future<Either<Failure, Uint8List?>> execute() async {
    return profileRepository.getProfilePicture();
  }
}
