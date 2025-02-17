import 'package:ai_sales_manager_mobile/data/models/common/result.dart';
import 'package:ai_sales_manager_mobile/data/models/user/user_account_response.dart';

abstract class UserRepository {
  Future<Result<UserAccountResponse>> getUserInfo({required String userId});
}
