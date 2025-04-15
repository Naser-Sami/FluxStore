import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure, NoParams;
import '/features/_features.dart' show Profile, IProfileRepository;

class GetProfileUseCase extends BaseUseCase<Profile, NoParams> {
  final IProfileRepository repository;
  GetProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, Profile>> call(NoParams p) async {
    try {
      return await repository.get();
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(error: e.toString(), statusCode: 500));
    }
  }
}
