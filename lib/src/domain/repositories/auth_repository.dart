import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/data/models/user/user_credential.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> signIn(
    String username,
    String password,
  );

  Future<Either<Failure, UserCredential?>> getUser();

  Future<Either<Failure, bool>> logOut();

  Future<Either<Failure, Map<String, String>>> getCredential();
}
