import 'package:dartz/dartz.dart';
import 'package:fake_store_app/core/usecase/usecase.dart';
import 'package:fake_store_app/presentation/home/domain/repository/home_repository.dart';
import 'package:fake_store_app/services_locator.dart';

class GetAllCategoryUseCase implements UseCase<Either<String, List<String>>, void> {
  @override
  Future<Either<String, List<String>>> call({void param}) {
    return sl<HomeRepository>().getAllCategories();
  }


}