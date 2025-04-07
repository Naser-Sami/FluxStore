import 'package:dartz/dartz.dart';
import '/core/_core.dart' show Failure;
import '/features/authentication/_authentication.dart'
    show UserEntity, LoginParams;

abstract class ILoginRepository {
  Future<Either<Failure<String>, UserEntity>> login(LoginParams loginParams);
}
