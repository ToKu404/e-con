import 'package:dartz/dartz.dart';
import 'package:e_con/core/common/failure.dart';
import 'package:e_con/src/data/models/user/user_credential.dart';
import 'package:e_con/src/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository authRepository;
  SignIn({required this.authRepository});

  Future<Either<Failure, UserCredential>> execute(
    String username,
    String password,
  ) {
    return authRepository.signIn(username, password);
  }
}
