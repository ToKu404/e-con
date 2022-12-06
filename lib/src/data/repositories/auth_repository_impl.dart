import 'package:e_con/core/common/exception.dart';
import 'package:e_con/src/data/datasources/auth_datasource.dart';
import 'package:e_con/src/data/models/user_credential.dart';
import 'package:e_con/core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_con/src/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, UserCredential>> signIn(
    String username,
    String password,
  ) async {
    try {
      final result = await authDataSource.signIn(username, password);
      return Right(result);
    } on AuthException {
      return const Left(AuthFailure('Gagal login'));
    }
  }
}
