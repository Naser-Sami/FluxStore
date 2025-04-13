import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure, BaseUseCase;
import '/features/_features.dart'
    show UserEntity, ISignUpRepository, SignUpParams;

class SignUpUseCase extends BaseUseCase<UserEntity, SignUpParams> {
  final ISignUpRepository signUpRepository;
  SignUpUseCase({required this.signUpRepository});

  @override
  Future<Either<Failure<String>, UserEntity>> call(p) async {
    try {
      return await signUpRepository.signUp(p);
    } catch (e) {
      return const Left(Failure(statusCode: 500, error: "Login error."));
    }
  }
}
