import 'package:dartz/dartz.dart';
import 'package:fake_store_app/core/domain/repository/auth_repository.dart';
import 'package:fake_store_app/core/usecase/usecase.dart';
import 'package:fake_store_app/services_locator.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either> call() async {
    return await repository.logout();
  }
}
