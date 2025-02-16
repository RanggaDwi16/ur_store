// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signin_req_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SigninReqParams _$SigninReqParamsFromJson(Map<String, dynamic> json) {
  return _SigninReqParams.fromJson(json);
}

/// @nodoc
mixin _$SigninReqParams {
  @JsonKey(name: "username")
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: "password")
  String? get password => throw _privateConstructorUsedError;

  /// Serializes this SigninReqParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SigninReqParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SigninReqParamsCopyWith<SigninReqParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SigninReqParamsCopyWith<$Res> {
  factory $SigninReqParamsCopyWith(
          SigninReqParams value, $Res Function(SigninReqParams) then) =
      _$SigninReqParamsCopyWithImpl<$Res, SigninReqParams>;
  @useResult
  $Res call(
      {@JsonKey(name: "username") String? username,
      @JsonKey(name: "password") String? password});
}

/// @nodoc
class _$SigninReqParamsCopyWithImpl<$Res, $Val extends SigninReqParams>
    implements $SigninReqParamsCopyWith<$Res> {
  _$SigninReqParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SigninReqParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SigninReqParamsImplCopyWith<$Res>
    implements $SigninReqParamsCopyWith<$Res> {
  factory _$$SigninReqParamsImplCopyWith(_$SigninReqParamsImpl value,
          $Res Function(_$SigninReqParamsImpl) then) =
      __$$SigninReqParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "username") String? username,
      @JsonKey(name: "password") String? password});
}

/// @nodoc
class __$$SigninReqParamsImplCopyWithImpl<$Res>
    extends _$SigninReqParamsCopyWithImpl<$Res, _$SigninReqParamsImpl>
    implements _$$SigninReqParamsImplCopyWith<$Res> {
  __$$SigninReqParamsImplCopyWithImpl(
      _$SigninReqParamsImpl _value, $Res Function(_$SigninReqParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SigninReqParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? password = freezed,
  }) {
    return _then(_$SigninReqParamsImpl(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SigninReqParamsImpl implements _SigninReqParams {
  const _$SigninReqParamsImpl(
      {@JsonKey(name: "username") this.username,
      @JsonKey(name: "password") this.password});

  factory _$SigninReqParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SigninReqParamsImplFromJson(json);

  @override
  @JsonKey(name: "username")
  final String? username;
  @override
  @JsonKey(name: "password")
  final String? password;

  @override
  String toString() {
    return 'SigninReqParams(username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SigninReqParamsImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  /// Create a copy of SigninReqParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SigninReqParamsImplCopyWith<_$SigninReqParamsImpl> get copyWith =>
      __$$SigninReqParamsImplCopyWithImpl<_$SigninReqParamsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SigninReqParamsImplToJson(
      this,
    );
  }
}

abstract class _SigninReqParams implements SigninReqParams {
  const factory _SigninReqParams(
          {@JsonKey(name: "username") final String? username,
          @JsonKey(name: "password") final String? password}) =
      _$SigninReqParamsImpl;

  factory _SigninReqParams.fromJson(Map<String, dynamic> json) =
      _$SigninReqParamsImpl.fromJson;

  @override
  @JsonKey(name: "username")
  String? get username;
  @override
  @JsonKey(name: "password")
  String? get password;

  /// Create a copy of SigninReqParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SigninReqParamsImplCopyWith<_$SigninReqParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
