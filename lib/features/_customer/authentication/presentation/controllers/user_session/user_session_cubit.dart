import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart' show ApiEndpoints, SecureStorageService, sl;
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
      setToken(user.token),
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

  Future<void> setToken(String token) async {
    await _storage.write(key: 'token', value: token);
    ApiEndpoints.token = token;
  }

  Future<void> getToken() async {
    final token = await _storage.read(key: 'token');
    ApiEndpoints.token = token ?? '';
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'token');
    ApiEndpoints.token = '';
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
