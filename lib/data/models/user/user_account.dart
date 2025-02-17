import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_account.freezed.dart';
part 'user_account.g.dart';

@freezed
abstract class UserAccount implements _$UserAccount {
  const UserAccount._();
  factory UserAccount({
    @JsonKey(name: 'account_id') @Default("") String accountId,
    @JsonKey(name: 'is_employee') @Default(false) bool isEmployee,
    @JsonKey(name: 'last_modified_date') @Default(0) int lastModifiedDate,
  }) = _UserAccount;

  factory UserAccount.fromJson(Map<String, dynamic> json) =>
      _$UserAccountFromJson(json);
}
