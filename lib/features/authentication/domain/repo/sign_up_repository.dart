import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/authentication/_authentication.dart'
    show UserEntity, SignUpParams;

abstract class ISignUpRepository {
  Future<Either<Failure<String>, UserEntity>> signUp(SignUpParams signUpParams);
}
