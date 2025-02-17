// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAccountImpl _$$UserAccountImplFromJson(Map<String, dynamic> json) =>
    _$UserAccountImpl(
      accountId: json['account_id'] as String? ?? "",
      isEmployee: json['is_employee'] as bool? ?? false,
      lastModifiedDate: (json['last_modified_date'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserAccountImplToJson(_$UserAccountImpl instance) =>
    <String, dynamic>{
      'account_id': instance.accountId,
      'is_employee': instance.isEmployee,
      'last_modified_date': instance.lastModifiedDate,
    };
