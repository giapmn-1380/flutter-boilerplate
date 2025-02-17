import 'package:flutter_boilerplate/data/models/common/result.dart';
import 'package:flutter_boilerplate/data/models/user/user_account_response.dart';
import 'package:flutter_boilerplate/data/remote/app_api_client.dart';
import 'package:flutter_boilerplate/data/repositories/user_repositories.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userRepositoryProvider =
    Provider((ref) => UserRepositoryImpl(ref.watch(apolloApiClientProvider)));

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._api);

  final AppApiClient _api;

  @override
  Future<Result<UserAccountResponse>> getUserInfo(
      {required String userId}) async {
    final result = await _api.getUserInfo(userId: userId);
    return result;
  }
}
