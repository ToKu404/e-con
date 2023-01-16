import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/profile/lecture_data.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';

abstract class ProfileRepository {
  Future<Either<Failure, StudentData?>> getStudentData();
  Future<Either<Failure, LectureData?>> getLectureData();
  Future<Either<Failure, Uint8List?>> getProfilePicture();
}
