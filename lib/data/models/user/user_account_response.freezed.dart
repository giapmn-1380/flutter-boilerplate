// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_account_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserAccountResponse _$UserAccountResponseFromJson(Map<String, dynamic> json) {
  return _UserAccountResponse.fromJson(json);
}

/// @nodoc
mixin _$UserAccountResponse {
  @JsonKey(name: 'items')
  List<UserAccount> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserAccountResponseCopyWith<UserAccountResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAccountResponseCopyWith<$Res> {
  factory $UserAccountResponseCopyWith(
          UserAccountResponse value, $Res Function(UserAccountResponse) then) =
      _$UserAccountResponseCopyWithImpl<$Res, UserAccountResponse>;
  @useResult
  $Res call({@JsonKey(name: 'items') List<UserAccount> items});
}

/// @nodoc
class _$UserAccountResponseCopyWithImpl<$Res, $Val extends UserAccountResponse>
    implements $UserAccountResponseCopyWith<$Res> {
  _$UserAccountResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<UserAccount>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserAccountResponseImplCopyWith<$Res>
    implements $UserAccountResponseCopyWith<$Res> {
  factory _$$UserAccountResponseImplCopyWith(_$UserAccountResponseImpl value,
          $Res Function(_$UserAccountResponseImpl) then) =
      __$$UserAccountResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'items') List<UserAccount> items});
}

/// @nodoc
class __$$UserAccountResponseImplCopyWithImpl<$Res>
    extends _$UserAccountResponseCopyWithImpl<$Res, _$UserAccountResponseImpl>
    implements _$$UserAccountResponseImplCopyWith<$Res> {
  __$$UserAccountResponseImplCopyWithImpl(_$UserAccountResponseImpl _value,
      $Res Function(_$UserAccountResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$UserAccountResponseImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<UserAccount>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAccountResponseImpl extends _UserAccountResponse {
  _$UserAccountResponseImpl(
      {@JsonKey(name: 'items') final List<UserAccount> items = const []})
      : _items = items,
        super._();

  factory _$UserAccountResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAccountResponseImplFromJson(json);

  final List<UserAccount> _items;
  @override
  @JsonKey(name: 'items')
  List<UserAccount> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'UserAccountResponse(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAccountResponseImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAccountResponseImplCopyWith<_$UserAccountResponseImpl> get copyWith =>
      __$$UserAccountResponseImplCopyWithImpl<_$UserAccountResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAccountResponseImplToJson(
      this,
    );
  }
}

abstract class _UserAccountResponse extends UserAccountResponse {
  factory _UserAccountResponse(
          {@JsonKey(name: 'items') final List<UserAccount> items}) =
      _$UserAccountResponseImpl;
  _UserAccountResponse._() : super._();

  factory _UserAccountResponse.fromJson(Map<String, dynamic> json) =
      _$UserAccountResponseImpl.fromJson;

  @override
  @JsonKey(name: 'items')
  List<UserAccount> get items;
  @override
  @JsonKey(ignore: true)
  _$$UserAccountResponseImplCopyWith<_$UserAccountResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
