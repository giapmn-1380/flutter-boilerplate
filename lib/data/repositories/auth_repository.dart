import 'package:flutter_boilerplate/data/local/preference_key.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);

abstract class AuthRepository {
  Future<bool> isLoggedIn();

  Future<void> login({required String email, required String password});

  Future<void> register({required String email, required String password});

  Future<void> logout();
}

/// Fake auth cho boilerplate — thay bằng API call thật khi tích hợp backend.
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> isLoggedIn() => PreferenceKey.hasLogin.getBool();

  @override
  Future<void> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    await PreferenceKey.hasLogin.setBool(true);
  }

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    await PreferenceKey.hasLogin.setBool(true);
  }

  @override
  Future<void> logout() async {
    await PreferenceKey.hasLogin.remove();
  }
}
