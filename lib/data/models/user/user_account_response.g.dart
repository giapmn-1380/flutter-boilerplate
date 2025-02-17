// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAccountResponseImpl _$$UserAccountResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UserAccountResponseImpl(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => UserAccount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserAccountResponseImplToJson(
        _$UserAccountResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
