import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart'
    show
        ForgotPasswordParams,
        IForgotPasswordRepository,
        IAuthenticationRemoteDataSource;

class ForgotPasswordRepository implements IForgotPasswordRepository {
  final IAuthenticationRemoteDataSource remoteDataSource;
  ForgotPasswordRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure<String>, String>> forgotPassword(
    ForgotPasswordParams params,
  ) async {
    try {
      final token = await remoteDataSource.forgotPassword(params);
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
