import 'package:flutter_boilerplate/data/models/user/user_account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_account_response.freezed.dart';
part 'user_account_response.g.dart';

@freezed
abstract class UserAccountResponse implements _$UserAccountResponse {
  const UserAccountResponse._();
  factory UserAccountResponse({
    @JsonKey(name: 'items') @Default([]) List<UserAccount> items,
  }) = _UserAccountResponse;

  factory UserAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAccountResponseFromJson(json);
}
