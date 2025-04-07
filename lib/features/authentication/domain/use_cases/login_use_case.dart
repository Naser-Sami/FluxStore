import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure, BaseUseCase;
import '/features/authentication/_authentication.dart'
    show UserEntity, ILoginRepository, LoginParams;

class LoginUseCase extends BaseUseCase<UserEntity, LoginParams> {
  final ILoginRepository loginRepository;
  LoginUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, UserEntity>> call(p) async {
    try {
      return await loginRepository.login(p);
    } catch (e) {
      return const Left(Failure(statusCode: 500, error: "Login error."));
    }
  }
}
