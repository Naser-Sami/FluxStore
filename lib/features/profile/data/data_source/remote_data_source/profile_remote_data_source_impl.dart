import '/core/_core.dart' show ApiClient, ApiEndpoints, sl;
import '/features/_features.dart'
    show IProfileRemoteDataSource, ProfileModel, UpdateProfileParams;

class ProfileRemoteDataSourceImpl implements IProfileRemoteDataSource {
  final ApiClient apiClient = sl<ApiClient>();

  @override
  Future<ProfileModel> get() async {
    try {
      final response = await apiClient.get<ProfileModel>(
        path: ApiEndpoints.profile,
        parser: (data) => ProfileModel.fromJson(data),
      );
      if (response == null) return ProfileModel.empty();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(UpdateProfileParams params) async {
    try {
      final response = await apiClient.put<ProfileModel>(
        path: ApiEndpoints.profile,
        data: params.toMap(),
        parser: (data) => ProfileModel.fromJson(data),
      );
      if (response == null) return;
    } catch (e) {
      rethrow;
    }
  }
}
