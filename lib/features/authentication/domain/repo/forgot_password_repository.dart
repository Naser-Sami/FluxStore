import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart' show ForgotPasswordParams;

abstract class IForgotPasswordRepository {
  Future<Either<Failure<String>, String>> forgotPassword(
    ForgotPasswordParams params,
  );
}
