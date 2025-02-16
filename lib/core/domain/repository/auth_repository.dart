import 'package:dartz/dartz.dart';
import 'package:fake_store_app/core/data/models/signin_req_params.dart';

abstract class AuthRepository {
  Future<Either> login(SigninReqParams signinReq);
  Future<bool> isLoggedIn();
  Future<Either> logout();
}
