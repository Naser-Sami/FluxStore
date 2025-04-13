import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '../../_authentication.dart';

class ForgotPasswordRepositoryImplementation
    implements IForgotPasswordRepository {
  final IAuthenticationRemoteDataSource authenticationRemoteDataSource;
  ForgotPasswordRepositoryImplementation({
    required this.authenticationRemoteDataSource,
  });

  @override
  Future<Either<Failure<String>, String>> forgotPassword(
    ForgotPasswordParams params,
  ) async {
    try {
      final token = await authenticationRemoteDataSource.forgotPassword(params);
      if (token != null) {
        return Right(token);
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
