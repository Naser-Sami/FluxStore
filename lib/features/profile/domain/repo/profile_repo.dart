import 'package:dartz/dartz.dart' show Either;

import '/core/_core.dart' show Failure;
import '/features/_features.dart' show Profile, UpdateProfileParams;

abstract class IProfileRepository {
  Future<Either<Failure, Profile>> get();
  Future<Either<Failure, bool>> update(UpdateProfileParams params);
}
