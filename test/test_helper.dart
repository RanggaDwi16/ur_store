import 'package:fake_store_app/core/domain/repository/auth_repository.dart';
import 'package:fake_store_app/presentation/home/data/source/home_local_service.dart';
import 'package:fake_store_app/presentation/home/domain/repository/home_repository.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_all_product.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_product.dart';
import 'package:fake_store_app/services_locator.dart';
import 'package:mocktail/mocktail.dart';

import 'presentation/home/bloc/all_products_cubit_test.dart';
import 'presentation/home/bloc/cart_cubit_test.dart';
import 'presentation/home/bloc/product_cubit_test.dart';
import 'presentation/home/domain/usecase/get_all_product_test.dart';

// ✅ Mock AuthRepository
class MockAuthRepository extends Mock implements AuthRepository {}

void setupTestLocator() {
  sl.reset(); // Bersihkan GetIt sebelum daftar ulang
  sl.registerSingleton<AuthRepository>(MockAuthRepository());
  sl.registerSingleton<HomeRepository>(MockHomeRepository());
  sl.registerSingleton<HomeLocalService>(MockHomeLocalService());
  sl.registerSingleton<GetProductUseCase>(MockGetProductUseCase());
  sl.registerSingleton<GetAllProductUseCase>(MockGetAllProductUseCase()); // ✅ Tambahkan ini
}
