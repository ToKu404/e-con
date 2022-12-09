import 'package:dartz/dartz.dart';
import 'package:e_con/core/common/failure.dart';
import 'package:e_con/src/data/models/user_credential.dart';
import 'package:e_con/src/domain/repositories/auth_repository.dart';

class GetUser {
  final AuthRepository authRepository;
  GetUser({required this.authRepository});

  Future<Either<Failure, UserCredential?>> execute() {
    return authRepository.getUser();
  }
}
