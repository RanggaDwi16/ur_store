import 'package:fake_store_app/common/bloc/auth/cubit/auth_cubit.dart';
import 'package:fake_store_app/core/network/dio_client.dart';
import 'package:fake_store_app/core/data/repository/auth_repository_impl.dart';
import 'package:fake_store_app/core/data/source/auth_api_service.dart';
import 'package:fake_store_app/core/data/source/auth_local_service.dart';
import 'package:fake_store_app/core/domain/repository/auth_repository.dart';
import 'package:fake_store_app/core/domain/usecases/is_logged_in.dart';
import 'package:fake_store_app/core/domain/usecases/login.dart';
import 'package:fake_store_app/presentation/home/bloc/all_categories/cubit/all_categories_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/all_categories/selected_category_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/all_products/cubit/all_products_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/cart/cubit/cart_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/product/cubit/product_cubit.dart';
import 'package:fake_store_app/presentation/home/data/repository/home_repository_impl.dart';
import 'package:fake_store_app/presentation/home/data/source/home_api_service.dart';
import 'package:fake_store_app/presentation/home/data/source/home_local_service.dart';
import 'package:fake_store_app/presentation/home/domain/repository/home_repository.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_all_category.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_all_product.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_product.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

/// ✅ **Tutup Semua Cubit Sebelum Logout**
void closeAllCubit() {
  if (sl.isRegistered<AllCategoriesCubit>()) sl<AllCategoriesCubit>().close();
  if (sl.isRegistered<SelectedCategoryCubit>())
    sl<SelectedCategoryCubit>().close();
  if (sl.isRegistered<AllProductsCubit>()) sl<AllProductsCubit>().close();
  if (sl.isRegistered<CartCubit>()) sl<CartCubit>().close();
  if (sl.isRegistered<ProductCubit>()) sl<ProductCubit>().close();
  if (sl.isRegistered<AuthStateCubit>()) sl<AuthStateCubit>().close();
}

/// ✅ **Unregister Semua Cubit Sebelum Login Ulang**
void resetCubit() {
  if (sl.isRegistered<AllCategoriesCubit>())
    sl.unregister<AllCategoriesCubit>();
  if (sl.isRegistered<SelectedCategoryCubit>())
    sl.unregister<SelectedCategoryCubit>();
  if (sl.isRegistered<AllProductsCubit>()) sl.unregister<AllProductsCubit>();
  if (sl.isRegistered<CartCubit>()) sl.unregister<CartCubit>();
  if (sl.isRegistered<ProductCubit>()) sl.unregister<ProductCubit>();
  if (sl.isRegistered<AuthStateCubit>()) sl.unregister<AuthStateCubit>();

  // ✅ **Daftarkan ulang dengan `registerLazySingleton` agar bisa diakses di mode release**
  sl.registerLazySingleton<AuthStateCubit>(() => AuthStateCubit());
  sl.registerLazySingleton<AllProductsCubit>(
      () => AllProductsCubit(usecase: sl()));
  sl.registerLazySingleton<AllCategoriesCubit>(() => AllCategoriesCubit(sl()));
  sl.registerLazySingleton<SelectedCategoryCubit>(
      () => SelectedCategoryCubit());
  sl.registerLazySingleton<ProductCubit>(() => ProductCubit(sl()));
  sl.registerLazySingleton<CartCubit>(() => CartCubit());
}

/// ✅ **Inisialisasi Semua Service**
void setupServiceLocator() {
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Services
  sl.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl());
  sl.registerLazySingleton<AuthLocalService>(() => AuthLocalServiceImpl());
  sl.registerLazySingleton<HomeApiService>(() => HomeApiServiceImpl());
  sl.registerLazySingleton<HomeLocalService>(() => HomeLocalService());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));

  // UseCases
  sl.registerLazySingleton<IsLoggedInUseCase>(() => IsLoggedInUseCase());
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<GetAllProductUseCase>(
      () => GetAllProductUseCase(sl()));
  sl.registerLazySingleton<GetAllCategoryUseCase>(
      () => GetAllCategoryUseCase());
  sl.registerLazySingleton<GetProductUseCase>(() => GetProductUseCase(sl()));

  // ✅ **Cubit & State Management**
  sl.registerLazySingleton<AuthStateCubit>(() => AuthStateCubit());
  sl.registerLazySingleton<AllProductsCubit>(
      () => AllProductsCubit(usecase: sl()));
  sl.registerLazySingleton<AllCategoriesCubit>(() => AllCategoriesCubit(sl()));
  sl.registerLazySingleton<SelectedCategoryCubit>(
      () => SelectedCategoryCubit());
  sl.registerLazySingleton<ProductCubit>(() => ProductCubit(sl()));
  sl.registerLazySingleton<CartCubit>(() => CartCubit());
}
