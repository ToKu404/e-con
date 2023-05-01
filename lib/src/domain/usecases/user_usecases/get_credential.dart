import 'package:dartz/dartz.dart';
import 'package:e_con/core/utils/failure.dart';
import 'package:e_con/src/domain/repositories/auth_repository.dart';

class GetCredential {
  final AuthRepository authRepository;
  GetCredential({required this.authRepository});

  Future<Either<Failure, Map<String, String>>> execute() {
    return authRepository.getCredential();
  }
}
