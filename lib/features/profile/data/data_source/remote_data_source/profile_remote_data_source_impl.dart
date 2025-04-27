import 'dart:io';

import 'package:dio/dio.dart';

import '/core/_core.dart' show ApiClient, ApiEndpoints, sl;
import '/features/_features.dart'
    show IProfileRemoteDataSource, ProfileModel, UpdateProfileParams;

class ProfileRemoteDataSource implements IProfileRemoteDataSource {
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
      final response = await apiClient.put<String>(
        path: ApiEndpoints.profile,
        data: params.toMap(),
      );
      if (response == null) return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'profile.jpg',
        ),
      });
      final response = await sl<ApiClient>().post<Map<String, dynamic>>(
        path: ApiEndpoints.updateProfileImage,
        data: formData,
        parser: (data) => data,
      );

      return response?['imageUrl'] ?? '';
    } catch (e) {
      rethrow;
    }
  }
}
