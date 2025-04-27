import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure, BaseUseCase;
import '/features/_features.dart'
    show UserEntity, ILoginRepository, LoginParams;

class LoginUseCase extends BaseUseCase<UserEntity, LoginParams> {
  final ILoginRepository repository;
  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure<String>, UserEntity>> call(p) async {
    try {
      return await repository.login(p);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }
}
