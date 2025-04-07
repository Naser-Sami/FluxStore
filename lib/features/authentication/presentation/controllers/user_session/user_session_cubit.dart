import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart' show SecureStorageService, sl;
import '/features/_features.dart' show UserEntity, UserMapper, UserModel;

class UserSessionCubit extends Cubit<UserEntity?> {
  final _storage = sl<SecureStorageService>();
  UserSessionCubit() : super(null);

  Future<void> setUser(UserEntity user) async => emit(user);
  void _clear() => emit(null);

  Future<void> saveUser(UserEntity user) async {
    final userModel = UserMapper.toModel(user);
    final jsonData = jsonEncode(userModel.toJson());
    await _storage.write(key: 'user', value: jsonData);

    setUser(user);
  }

  Future<UserEntity?> getSavedUser() async {
    final data = await _storage.read(key: 'user');
    if (data == null) return null;

    final jsonData = jsonDecode(data);
    // Check if the JSON data is a Map
    if (jsonData is! Map<String, dynamic>) {
      throw Exception('Invalid JSON data');
    }

    final userModel = UserModel.fromJson(jsonData);
    final user = UserMapper.toEntity(userModel);

    return user;
  }

  Future<void> clearUser() async {
    await _storage.delete(key: 'user');
    _clear();
  }
  
  Future<void> logout() async {
    await clearUser();
  }
}
