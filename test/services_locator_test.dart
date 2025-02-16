// import 'package:fake_store_app/common/bloc/auth/cubit/auth_cubit.dart';
// import 'package:fake_store_app/core/network/dio_client.dart';
// import 'package:fake_store_app/core/data/repository/auth_repository_impl.dart';
// import 'package:fake_store_app/core/data/source/auth_api_service.dart';
// import 'package:fake_store_app/core/data/source/auth_local_service.dart';
// import 'package:fake_store_app/core/domain/repository/auth_repository.dart';
// import 'package:fake_store_app/core/domain/usecases/is_logged_in.dart';
// import 'package:fake_store_app/core/domain/usecases/login.dart';
// import 'package:fake_store_app/presentation/home/bloc/all_categories/cubit/all_categories_cubit.dart';
// import 'package:fake_store_app/presentation/home/bloc/all_categories/selected_category_cubit.dart';
// import 'package:fake_store_app/presentation/home/bloc/all_products/cubit/all_products_cubit.dart';
// import 'package:fake_store_app/presentation/home/bloc/cart/cubit/cart_cubit.dart';
// import 'package:fake_store_app/presentation/home/bloc/product/cubit/product_cubit.dart';
// import 'package:fake_store_app/presentation/home/data/repository/home_repository_impl.dart';
// import 'package:fake_store_app/presentation/home/data/source/home_api_service.dart';
// import 'package:fake_store_app/presentation/home/data/source/home_local_service.dart';
// import 'package:fake_store_app/presentation/home/domain/repository/home_repository.dart';
// import 'package:fake_store_app/presentation/home/domain/usecase/get_all_category.dart';
// import 'package:fake_store_app/presentation/home/domain/usecase/get_all_product.dart';
// import 'package:fake_store_app/presentation/home/domain/usecase/get_product.dart';
// import 'package:fake_store_app/services_locator.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   setUp(() {
//     // ✅ Pastikan service locator sudah diatur sebelum test
//     setupServiceLocator(
      
//     );
//   });

//   tearDown(() {
//     // ✅ Reset service locator setelah tiap test untuk menghindari conflict
//     sl.reset();
//   });

//   group('✅ Service Locator Tests', () {
//     test('✅ DioClient harus terdaftar', () {
//       expect(sl<DioClient>(), isA<DioClient>());
//     });

//     test('✅ Services harus terdaftar dengan benar', () {
//       expect(sl<AuthApiService>(), isA<AuthApiServiceImpl>());
//       expect(sl<AuthLocalService>(), isA<AuthLocalServiceImpl>());
//       expect(sl<HomeApiService>(), isA<HomeApiServiceImpl>());
//       expect(sl<HomeLocalService>(), isA<HomeLocalService>());
//     });

//     test('✅ Repositories harus terdaftar dengan benar', () {
//       expect(sl<AuthRepository>(), isA<AuthRepositoryImpl>());
//       expect(sl<HomeRepository>(), isA<HomeRepositoryImpl>());
//     });

//     test('✅ UseCases harus terdaftar dengan benar', () {
//       expect(sl<IsLoggedInUseCase>(), isA<IsLoggedInUseCase>());
//       expect(sl<LoginUseCase>(), isA<LoginUseCase>());
//       expect(sl<GetAllProductUseCase>(), isA<GetAllProductUseCase>());
//       expect(sl<GetAllCategoryUseCase>(), isA<GetAllCategoryUseCase>());
//       expect(sl<GetProductUseCase>(), isA<GetProductUseCase>());
//     });

//     test('✅ Cubits harus terdaftar dengan benar', () {
//       expect(sl<AuthStateCubit>(), isA<AuthStateCubit>());
//       expect(sl<AllProductsCubit>(), isA<AllProductsCubit>());
//       expect(sl<AllCategoriesCubit>(), isA<AllCategoriesCubit>());
//       expect(sl<SelectedCategoryCubit>(), isA<SelectedCategoryCubit>());
//       expect(sl<ProductCubit>(), isA<ProductCubit>());
//       expect(sl<CartCubit>(), isA<CartCubit>());
//     });
//   });
// }
