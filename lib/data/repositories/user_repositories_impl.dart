import 'package:ai_sales_manager_mobile/data/models/common/result.dart';
import 'package:ai_sales_manager_mobile/data/models/user/user_account_response.dart';
import 'package:ai_sales_manager_mobile/data/remote/app_api_client.dart';
import 'package:ai_sales_manager_mobile/data/repositories/user_repositories.dart';
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
