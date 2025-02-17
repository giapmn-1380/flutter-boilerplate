import 'package:flutter_boilerplate/data/models/common/result.dart';
import 'package:flutter_boilerplate/data/models/user/user_account_response.dart';
import 'package:flutter_boilerplate/data/remote/dio_client.dart';
import 'package:flutter_boilerplate/view_models/common/common_provider.dart';
import 'package:flutter_boilerplate/view_models/common/error_notifier.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final apolloApiClientProvider = Provider<AppApiClient>(
  (ref) => _ApolloApiClientImpl(
      ref.watch(dioClientProvider), ref.watch(errorProvider)),
);

abstract class AppApiClient {
  const AppApiClient();

  Future<Result<UserAccountResponse>> getUserInfo({required String userId});
}

class _ApolloApiClientImpl extends AppApiClient {
  _ApolloApiClientImpl(this._dioApi, this._errorHandler);

  final Dio _dioApi;
  final ErrorHandler _errorHandler;

  @override
  Future<Result<UserAccountResponse>> getUserInfo({required String userId}) {
    return Result.guardFuture(
      () async {
        final res = await _dioApi.get(
            '/2.3/users?page=1&order=desc&max=10&sort=reputation&site=stackoverflow');
        return UserAccountResponse.fromJson(res.data!);
      },
      _errorHandler,
    );
  }
}
