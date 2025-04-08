import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure, BaseUseCase;
import '/features/authentication/_authentication.dart'
    show IForgotPasswordRepository, ForgotPasswordParams;

class ForgotPasswordUseCase extends BaseUseCase<String, ForgotPasswordParams> {
  final IForgotPasswordRepository forgotPasswordRepository;
  ForgotPasswordUseCase({required this.forgotPasswordRepository});

  @override
  Future<Either<Failure, String>> call(ForgotPasswordParams p) async {
    try {
      return await forgotPasswordRepository.forgotPassword(p);
    } catch (e) {
      return const Left(
        Failure(statusCode: 500, error: "Forgot password error."),
      );
    }
  }
}
