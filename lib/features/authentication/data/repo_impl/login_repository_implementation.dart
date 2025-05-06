import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart'
    show
        LoginParams,
        ILoginRepository,
        IAuthenticationRemoteDataSource,
        UserEntity,
        UserMapper;

class LoginRepository implements ILoginRepository {
  final IAuthenticationRemoteDataSource dataSource;
  LoginRepository({required this.dataSource});

  @override
  Future<Either<Failure<String>, UserEntity>> login(
    LoginParams loginParams,
  ) async {
    try {
      final result = await dataSource.login(loginParams);

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
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }
}
