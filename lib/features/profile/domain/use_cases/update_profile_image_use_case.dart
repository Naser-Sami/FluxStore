import 'dart:io';

import 'package:dartz/dartz.dart';

import '/core/_core.dart' show BaseUseCase, Failure;
import '/features/_features.dart' show IProfileRepository;

class UpdateProfileImageUseCase extends BaseUseCase<String?, File> {
  final IProfileRepository repository;
  UpdateProfileImageUseCase({required this.repository});

  @override
  Future<Either<Failure, String?>> call(File p) async {
    try {
      return await repository.uploadProfileImage(p);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(error: e.toString(), statusCode: 500));
    }
  }
}
