import 'package:dartz/dartz.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/presentation/home/domain/repository/home_repository.dart';

class GetProductUseCase {
  final HomeRepository repository;

  GetProductUseCase(this.repository);

  Future<Either<String, ProductModel>> call({required int? param}) async {
    if (param == null) {
      return Left("Invalid product ID");
    }
    return await repository.getProduct(id: param);
  }
}
