import 'package:dartz/dartz.dart';
import 'package:fake_store_app/core/usecase/usecase.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/presentation/home/domain/repository/home_repository.dart';

class GetAllProductUseCase extends UseCase<Either<String, List<ProductModel>>, void> {
  final HomeRepository repository;

  GetAllProductUseCase(this.repository); // ✅ Tambahkan constructor
  
  @override
  Future<Either<String, List<ProductModel>>> call({void param}) async {
    return repository.getAllProducts(); // ✅ Gunakan instance repository yang di-pass
  }
}

