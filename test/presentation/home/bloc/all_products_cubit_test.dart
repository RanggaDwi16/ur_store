import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_store_app/presentation/home/bloc/all_products/cubit/all_products_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/all_products/cubit/all_products_state.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_all_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helper.dart';

// ✅ Mock UseCase
class MockGetAllProductUseCase extends Mock implements GetAllProductUseCase {}

void main() {
  late AllProductsCubit cubit;
  late MockGetAllProductUseCase mockUseCase;

  setUp(() {
    setupTestLocator();
    mockUseCase = MockGetAllProductUseCase();
    cubit = AllProductsCubit(usecase: mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  final tProductList = [
    ProductModel(id: 1, title: "Product 1", price: 100),
    ProductModel(id: 2, title: "Product 2", price: 200),
  ];

  blocTest<AllProductsCubit, AllProductsState>(
    '🔹 Harus mengeluarkan [AllProductsLoading, AllProductsSuccess] ketika produk berhasil dimuat',
    build: () {
      when(() => mockUseCase.call())
          .thenAnswer((_) async => Right(tProductList));
      return cubit;
    },
    act: (cubit) => cubit.getAllProducts(),
    expect: () => [
      AllProductsLoading(),
      AllProductsSuccess(products: tProductList),
    ],
  );

  blocTest<AllProductsCubit, AllProductsState>(
    '🔴 Harus mengeluarkan [AllProductsLoading, AllProductsFailure] jika gagal memuat produk',
    build: () {
      when(() => mockUseCase.call())
          .thenAnswer((_) async => Left("Error fetching products"));
      return cubit;
    },
    act: (cubit) => cubit.getAllProducts(),
    expect: () => [
      AllProductsLoading(),
      AllProductsFailure(errorMessage: "Error fetching products"),
    ],
  );
}
