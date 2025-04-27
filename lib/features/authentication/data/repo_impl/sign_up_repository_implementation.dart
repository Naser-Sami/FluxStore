import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart'
    show
        SignUpParams,
        ISignUpRepository,
        IAuthenticationRemoteDataSource,
        UserEntity,
        UserMapper;

class SignUpRepository implements ISignUpRepository {
  final IAuthenticationRemoteDataSource remoteDataSource;
  SignUpRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure<String>, UserEntity>> signUp(
    SignUpParams signUpParams,
  ) async {
    try {
      final result = await remoteDataSource.signUp(signUpParams);

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
