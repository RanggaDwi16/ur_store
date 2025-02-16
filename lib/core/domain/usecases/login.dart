import 'package:dartz/dartz.dart';
import 'package:fake_store_app/core/data/models/signin_req_params.dart';
import 'package:fake_store_app/core/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either> call({required SigninReqParams param}) async {
    return await repository.login(param);
  }
}
