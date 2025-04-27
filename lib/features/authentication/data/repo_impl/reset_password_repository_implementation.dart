import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart'
    show
        ResetPasswordParams,
        IResetPasswordRepository,
        IAuthenticationRemoteDataSource;

class ResetPasswordRepository implements IResetPasswordRepository {
  final IAuthenticationRemoteDataSource remoteDataSource;
  ResetPasswordRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure<String>, String>> resetPassword(
    ResetPasswordParams params,
  ) async {
    try {
      final result = await remoteDataSource.resetPassword(params);
      if (result != null) {
        return Right(result);
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
