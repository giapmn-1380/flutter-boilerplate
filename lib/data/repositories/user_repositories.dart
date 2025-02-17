import 'package:flutter_boilerplate/data/models/common/result.dart';
import 'package:flutter_boilerplate/data/models/user/user_account_response.dart';

abstract class UserRepository {
  Future<Result<UserAccountResponse>> getUserInfo({required String userId});
}
