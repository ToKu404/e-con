import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/src/data/datasources/auth_datasource.dart';
import 'package:e_con/src/data/models/user/user_credential.dart';
import 'package:e_con/core/utils/failure.dart';
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
    } on UnauthenticateException {
      return const Left(AuthFailure('Username atau Password salah'));
    } on UserNotFoundException {
      return const Left(AuthFailure('User tidak ditemukan'));
    } on AuthException {
      return const Left(AuthFailure('Proses login gagal'));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> getUser() async {
    try {
      final result = await authDataSource.getUser();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      final result = await authDataSource.logOut();
      return Right(result);
    } on LocalDatabaseException {
      return const Left(AuthFailure('Terdapat masalah pada data user'));
    } on AuthException {
      return const Left(AuthFailure('Proses login bermasalah'));
    }
  }
}
