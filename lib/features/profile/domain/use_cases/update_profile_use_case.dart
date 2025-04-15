import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show UpdateProfileParams, IProfileRepository;

class UpdateProfileUseCase extends BaseUseCase<void, UpdateProfileParams> {
  final IProfileRepository repository;
  UpdateProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(UpdateProfileParams p) async {
    try {
      return await repository.update(p);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(error: e.toString(), statusCode: 500));
    }
  }
}
