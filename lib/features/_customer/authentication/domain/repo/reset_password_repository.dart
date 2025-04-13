import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart' show ResetPasswordParams;

abstract class IResetPasswordRepository {
  Future<Either<Failure<String>, String>> resetPassword(
    ResetPasswordParams params,
  );
}
