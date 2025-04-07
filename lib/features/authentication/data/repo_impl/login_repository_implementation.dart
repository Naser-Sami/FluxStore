import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/authentication/_authentication.dart'
    show
        ILoginRepository,
        UserEntity,
        LoginParams,
        UserMapper,
        IAuthenticationRemoteDataSource;

class LoginRepositoryImplementation implements ILoginRepository {
  final IAuthenticationRemoteDataSource authenticationRemoteDataSource;
  LoginRepositoryImplementation({required this.authenticationRemoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login(LoginParams loginParams) async {
    try {
      final result = await authenticationRemoteDataSource.login(loginParams);

      // Map the result to the UserEntity
      if (result != null) {
        final resultEntity = UserMapper.toEntity(result);
        return Right(resultEntity);
      }

      return const Left(
        Failure(statusCode: 400, error: "Something went wrong."),
      );
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return const Left(Failure(statusCode: 500, error: "Registration error."));
    }
  }
}
