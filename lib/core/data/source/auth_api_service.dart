import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fake_store_app/core/constants/api_url.dart';
import 'package:fake_store_app/core/network/dio_client.dart';
import 'package:fake_store_app/core/data/models/signin_req_params.dart';
import 'package:fake_store_app/services_locator.dart';

abstract class AuthApiService {
  Future<Either> login(SigninReqParams signinReq);
}

class AuthApiServiceImpl implements AuthApiService {
  @override
  Future<Either> login(SigninReqParams signinReq) async {
    try {
      var response =
          await sl<DioClient>().post(ApiUrl.login, data: signinReq.toJson());

      final token = response.data['token'];
      return Right(token);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Left('❌ Unauthorized: Invalid username or password.');
      } else if (e.response?.statusCode == 500) {
        return Left('🚨 Server error: Please try again later.');
      } else {
        return Left('⚠️ Error: ${e.message}');
      }
    }
  }
}
