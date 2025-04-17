import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart'
    show ApiEndpoints, Constants, SecureStorageService, sl;
import '/features/_features.dart' show UserEntity, UserMapper, UserModel;

class UserSessionCubit extends Cubit<UserEntity?> {
  final _storage = sl<SecureStorageService>();
  UserSessionCubit() : super(null);

  Future<void> setUser(UserEntity user) async => emit(user);
  void _clear() => emit(null);

  Future<void> saveUser(UserEntity user) async {
    await clearUser();
    final userModel = UserMapper.toModel(user);
    final jsonData = jsonEncode(userModel.toJson());

    await Future.wait([
      setAccessToken(user.token),
      setRefreshToken(user.refreshToken),
      _storage.write(key: Constants.keyUserSession, value: jsonData),
    ]);

    await setUser(user);
  }

  Future<UserEntity?> getSavedUser() async {
    final data = await _storage.read(key: Constants.keyUserSession);
    if (data == null) return null;

    try {
      final jsonData = jsonDecode(data);
      // Check if the JSON data is a Map
      if (jsonData is! Map<String, dynamic>) {
        throw Exception('Invalid JSON data');
      }

      final userModel = UserModel.fromJson(jsonData);
      final user = UserMapper.toEntity(userModel);

      await Future.wait([getAccessToken(), getRefreshToken()]);

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> setAccessToken(String token) async {
    await _storage.write(key: Constants.keyAccessToken, value: token);
    ApiEndpoints.accessToken = token;
  }

  Future<void> setRefreshToken(String refreshToken) async {
    await _storage.write(key: Constants.keyRefreshToken, value: refreshToken);
    ApiEndpoints.refreshToken = refreshToken;
  }

  Future<void> getAccessToken() async {
    final token = await _storage.read(key: Constants.keyAccessToken);
    ApiEndpoints.accessToken = token ?? '';
  }

  Future<void> getRefreshToken() async {
    final refreshToken = await _storage.read(key: Constants.keyRefreshToken);
    ApiEndpoints.refreshToken = refreshToken ?? '';
  }

  Future<void> clearAccessToken() async {
    await _storage.delete(key: Constants.keyAccessToken);
    ApiEndpoints.accessToken = null;
  }

  Future<void> clearRefreshToken() async {
    await _storage.delete(key: Constants.keyRefreshToken);
    ApiEndpoints.refreshToken = null;
  }

  Future<void> clearUser() async {
    await Future.wait([
      _storage.delete(key: Constants.keyUserSession),
      clearAccessToken(),
    ]);

    _clear();
  }

  Future<void> logout() async {
    // Do not clear the refresh token here
    await Future.wait([clearAccessToken(), clearUser()]);
  }
}
