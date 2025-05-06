import 'dart:io';

import 'package:dartz/dartz.dart';

import '/core/_core.dart' show Failure;
import '/features/_features.dart'
    show
        IProfileRemoteDataSource,
        IProfileRepository,
        Profile,
        UpdateProfileParams,
        ProfileMapper;

class ProfileRepository implements IProfileRepository {
  final IProfileRemoteDataSource dataSource;

  ProfileRepository({required this.dataSource});

  @override
  Future<Either<Failure, Profile>> get() async {
    try {
      final result = await dataSource.get();
      final resultEntity = ProfileMapper.toEntity(result);
      return Right(resultEntity);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> update(UpdateProfileParams params) async {
    try {
      await dataSource.update(params);

      return const Right(true);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> uploadProfileImage(File imageFile) async {
    try {
      await dataSource.uploadProfileImage(imageFile);

      return Right(imageFile.path);
    } on Failure catch (e) {
      return Left(Failure(statusCode: e.statusCode, error: e.error));
    } catch (e) {
      return Left(Failure(statusCode: 500, error: e.toString()));
    }
  }
}
