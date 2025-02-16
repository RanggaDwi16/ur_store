import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fake_store_app/core/constants/api_url.dart';
import 'package:fake_store_app/core/network/dio_client.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/services_locator.dart';

abstract class HomeApiService {
  Future<Either<String, List<ProductModel>>> getAllProducts();
  Future<Either<String, ProductModel>> getProduct({required int id});
  Future<Either<String, List<String>>> getAllCategories();
}

class HomeApiServiceImpl implements HomeApiService {
  @override
  Future<Either<String, List<ProductModel>>> getAllProducts() async {
    try {
      var response = await sl<DioClient>().get(ApiUrl.products);
      List<ProductModel> products = (response.data as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
      return Right(products);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either<String, List<String>>> getAllCategories() async {
    try {
      var response = await sl<DioClient>().get(ApiUrl.categories);

      if (response.data is List) {
        return Right(List<String>.from(response.data));
      } else {
        return Left("Unexpected data format");
      }
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "Failed to fetch categories");
    } catch (e) {
      return Left("Unexpected error: $e");
    }
  }

  @override
  Future<Either<String, ProductModel>> getProduct({required int id}) async {
    try {
      var response = await sl<DioClient>().get("${ApiUrl.products}/$id");
      ProductModel product = ProductModel.fromJson(response.data);
      return Right(product);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
