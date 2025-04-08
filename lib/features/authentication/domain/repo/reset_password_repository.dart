import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/authentication/_authentication.dart' show ResetPasswordParams;

abstract class IResetPasswordRepository {
  Future<Either<Failure<String>, String>> resetPassword(
    ResetPasswordParams params,
  );
}
