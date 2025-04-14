import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure, BaseUseCase;
import '/features/_features.dart'
    show IResetPasswordRepository, ResetPasswordParams;

class ResetPasswordUseCase extends BaseUseCase<String, ResetPasswordParams> {
  final IResetPasswordRepository resetPasswordRepository;
  ResetPasswordUseCase({required this.resetPasswordRepository});

  @override
  Future<Either<Failure, String>> call(ResetPasswordParams p) async {
    try {
      return await resetPasswordRepository.resetPassword(p);
    } catch (e) {
      return const Left(
        Failure(statusCode: 500, error: "Reset password error."),
      );
    }
  }
}
