import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart'
    show
        SignUpParams,
        ISignUpRepository,
        IAuthenticationRemoteDataSource,
        UserEntity,
        UserMapper;

class SignUpRepositoryImplementation implements ISignUpRepository {
  final IAuthenticationRemoteDataSource authenticationRemoteDataSource;
  SignUpRepositoryImplementation({
    required this.authenticationRemoteDataSource,
  });

  @override
  Future<Either<Failure<String>, UserEntity>> signUp(
    SignUpParams signUpParams,
  ) async {
    try {
      final result = await authenticationRemoteDataSource.signUp(signUpParams);

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
