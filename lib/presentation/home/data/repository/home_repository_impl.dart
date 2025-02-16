import 'package:dartz/dartz.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/presentation/home/data/source/home_api_service.dart';
import 'package:fake_store_app/presentation/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeApiService homeApiService;

  HomeRepositoryImpl(this.homeApiService);

  

  @override
  Future<Either<String, List<ProductModel>>> getAllProducts() async {
    try {
      return await homeApiService.getAllProducts();
    } catch (e) {
      return Left(e.toString());
    }
  }


  @override
  Future<Either<String, List<String>>> getAllCategories() async{
    try {
      return await homeApiService.getAllCategories();
    } catch (e) {
      return Left(e.toString());
    }
  }
  
  @override
  Future<Either<String, ProductModel>> getProduct({required int id}) async {
    try{
      return await homeApiService.getProduct(id: id);
    } catch(e){
      return Left(e.toString());
    }
  }
}
