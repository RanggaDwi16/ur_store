import 'package:freezed_annotation/freezed_annotation.dart';

part 'signin_req_params.freezed.dart';
part 'signin_req_params.g.dart';

@freezed
class SigninReqParams with _$SigninReqParams {
  const factory SigninReqParams({
    @JsonKey(name: "username") String? username,
    @JsonKey(name: "password") String? password,
  }) = _SigninReqParams;

  factory SigninReqParams.fromJson(Map<String, dynamic> json) =>
      _$SigninReqParamsFromJson(json);
}
