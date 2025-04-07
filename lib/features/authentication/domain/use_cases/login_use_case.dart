import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '/core/_core.dart';
import '/features/authentication/_authentication.dart' show UserEntity;

class LoginUseCase extends BaseUseCase<UserEntity, LoginParams> {
  @override
  Future<Either<Failure, UserEntity>> call(p) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
// 