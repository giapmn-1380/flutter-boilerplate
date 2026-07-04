import 'package:flutter_boilerplate/data/repositories/auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

final authControllerProvider =
    NotifierProvider<AuthController, AuthStatus>(AuthController.new);

class AuthController extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    _restoreSession();
    return AuthStatus.unknown;
  }

  AuthRepository get _repository => ref.read(authRepositoryProvider);

  Future<void> _restoreSession() async {
    final loggedIn = await _repository.isLoggedIn();
    state = loggedIn ? AuthStatus.authenticated : AuthStatus.unauthenticated;
  }

  Future<void> login({required String email, required String password}) async {
    await _repository.login(email: email, password: password);
    state = AuthStatus.authenticated;
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    await _repository.register(email: email, password: password);
    state = AuthStatus.authenticated;
  }

  Future<void> logout() async {
    await _repository.logout();
    state = AuthStatus.unauthenticated;
  }
}
