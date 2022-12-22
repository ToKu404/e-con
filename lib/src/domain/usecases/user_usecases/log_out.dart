import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/domain/repositories/auth_repository.dart';

class LogOut {
  final AuthRepository authRepository;
  LogOut({required this.authRepository});

  Future<Either<Failure, bool>> execute() {
    return authRepository.logOut();
  }
}
