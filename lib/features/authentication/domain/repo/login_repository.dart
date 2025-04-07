import 'package:dartz/dartz.dart';
import '/core/_core.dart' show Failure;
import '/features/authentication/_authentication.dart' show UserEntity;

abstract class ILoginRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
}
