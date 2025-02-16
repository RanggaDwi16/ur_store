import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_store_app/presentation/home/bloc/product/cubit/product_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/product/cubit/product_state.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ✅ Mock UseCase
class MockGetProductUseCase extends Mock implements GetProductUseCase {}

void main() {
  late ProductCubit cubit;
  late MockGetProductUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetProductUseCase();
    cubit = ProductCubit(mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  final tProduct = ProductModel(id: 1, title: "Product 1", price: 100);

  blocTest<ProductCubit, ProductState>(
    '🔹 Harus mengeluarkan [ProductLoading, ProductSuccess] ketika produk berhasil dimuat',
    build: () {
      when(() => mockUseCase.call(param: any(named: 'param')))
          .thenAnswer((_) async => Right(tProduct));
      return cubit;
    },
    act: (cubit) => cubit.getProduct(1),
    expect: () => [
      ProductLoading(), // ✅ Sekarang hanya mengeluarkan ProductLoading pertama kali
      ProductSuccess(product: tProduct),
    ],
  );

  blocTest<ProductCubit, ProductState>(
    '🔴 Harus mengeluarkan [ProductLoading, ProductFailure] jika gagal memuat produk',
    build: () {
      when(() => mockUseCase.call(param: any(named: 'param')))
          .thenAnswer((_) async => Left("Error fetching product"));
      return cubit;
    },
    act: (cubit) => cubit.getProduct(1),
    expect: () => [
      ProductLoading(),
      ProductFailure(errorMessage: "Error fetching product"),
    ],
  );
}
