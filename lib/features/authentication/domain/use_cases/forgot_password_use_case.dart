import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure, BaseUseCase;
import '/features/_features.dart'
    show IForgotPasswordRepository, ForgotPasswordParams;

class ForgotPasswordUseCase extends BaseUseCase<String, ForgotPasswordParams> {
  final IForgotPasswordRepository repository;
  ForgotPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ForgotPasswordParams p) async {
    try {
      return await repository.forgotPassword(p);
    } catch (e) {
      return const Left(
        Failure(statusCode: 500, error: "Forgot password error."),
      );
    }
  }
}
