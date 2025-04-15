import '/features/_features.dart' show ProfileModel, UpdateProfileParams;

abstract class IProfileRemoteDataSource {
  Future<ProfileModel> get();
  Future<void> update(UpdateProfileParams params);
}
