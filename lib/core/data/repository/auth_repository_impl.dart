import 'package:dartz/dartz.dart';
import 'package:fake_store_app/core/data/models/signin_req_params.dart';
import 'package:fake_store_app/core/data/source/auth_api_service.dart';
import 'package:fake_store_app/core/data/source/auth_local_service.dart';
import 'package:fake_store_app/core/domain/repository/auth_repository.dart';
import 'package:fake_store_app/services_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<Either> login(SigninReqParams signinReq) async {
    Either result = await sl<AuthApiService>().login(signinReq);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', data);
      return Right(data);
    });
  }

  @override
  Future<Either> logout() async {
    return await sl<AuthLocalService>().logout();
  }
}
