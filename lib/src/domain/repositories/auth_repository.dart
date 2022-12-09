import 'package:dartz/dartz.dart';
import 'package:e_con/core/common/failure.dart';
import 'package:e_con/src/data/models/user_credential.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> signIn(
    String username,
    String password,
  );

  Future<Either<Failure, UserCredential?>> getUser();

  Future<Either<Failure, bool>> logOut();

}
