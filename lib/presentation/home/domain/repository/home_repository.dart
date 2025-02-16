import 'package:dartz/dartz.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';

abstract class HomeRepository {
  Future<Either<String, List<ProductModel>>> getAllProducts();
  Future<Either<String, List<String>>> getAllCategories();
  Future<Either<String, ProductModel>> getProduct({required int id});
}
