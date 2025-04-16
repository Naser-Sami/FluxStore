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
      setToken(user.token, user.refreshToken),
      _storage.write(key: 'user', value: jsonData),
    ]);

    await setUser(user);
  }

  Future<UserEntity?> getSavedUser() async {
    final data = await _storage.read(key: 'user');
    if (data == null) return null;

    try {
      final jsonData = jsonDecode(data);
      // Check if the JSON data is a Map
      if (jsonData is! Map<String, dynamic>) {
        throw Exception('Invalid JSON data');
      }

      final userModel = UserModel.fromJson(jsonData);
      final user = UserMapper.toEntity(userModel);

      await getToken();

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> setToken(String token, String refreshToken) async {
    await _storage.write(key: Constants.keyToken, value: token);
    await _storage.write(key: Constants.keyRefreshToken, value: refreshToken);

    ApiEndpoints.accessToken = token;
    ApiEndpoints.refreshToken = refreshToken;
  }

  Future<void> getToken() async {
    final token = await _storage.read(key: Constants.keyToken);
    final refreshToken = await _storage.read(key: Constants.keyRefreshToken);

    ApiEndpoints.accessToken = token ?? '';
    ApiEndpoints.refreshToken = refreshToken ?? '';
  }

  Future<void> clearToken() async {
    await _storage.delete(key: Constants.keyToken);
    await _storage.delete(key: Constants.keyRefreshToken);

    ApiEndpoints.accessToken = null;
    ApiEndpoints.refreshToken = null;
  }

  Future<void> clearUser() async {
    await _storage.delete(key: 'user');
    await clearToken();
    _clear();
  }

  Future<void> logout() async {
    await clearToken();
    await clearUser();
  }
}
