import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_store_app/presentation/home/bloc/product/cubit/product_cubit.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_product.dart';
import 'package:fake_store_app/presentation/home/pages/detail_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fake_store_app/services_locator.dart';

import '../../../test_helper.dart';

// ✅ Mock UseCase yang akan digunakan oleh ProductCubit
class MockGetProductUseCase extends Mock implements GetProductUseCase {}

void main() {
  late MockGetProductUseCase mockGetProductUseCase;
  late ProductCubit productCubit;

  const int tProductId = 1;
  final tProduct = ProductModel(
    id: tProductId,
    title: 'Test Product',
    price: 29.99,
    image: 'https://example.com/test.jpg',
    description: 'This is a test product',
    category: 'Test Category',
  );

  setUp(() {
    setupTestLocator();
    mockGetProductUseCase = MockGetProductUseCase();

    // ✅ Pastikan `call()` pada usecase mengembalikan `Future<Either<String, ProductModel>>`
    when(() => mockGetProductUseCase.call(param: tProductId))
        .thenAnswer((_) async => Right(tProduct));

    productCubit = ProductCubit(mockGetProductUseCase);
  });

  tearDown(() {
    productCubit.close();
  });

  Widget createDetailProductPage() {
    return BlocProvider<ProductCubit>.value(
      value: productCubit,
      child: const MaterialApp(
        home: DetailProductPage(productId: tProductId),
      ),
    );
  }

  testWidgets('✅ Menampilkan loading saat produk sedang dimuat',
      (WidgetTester tester) async {
    when(() => mockGetProductUseCase.call(param: tProductId))
        .thenAnswer((_) async => await Future.delayed(
              const Duration(milliseconds: 500),
              () => Right(tProduct),
            ));

    await tester.pumpWidget(createDetailProductPage());
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('✅ Menampilkan produk setelah berhasil di-fetch',
      (WidgetTester tester) async {
    when(() => mockGetProductUseCase.call(param: tProductId))
        .thenAnswer((_) async => Right(tProduct));

    await tester.pumpWidget(createDetailProductPage());

    // Jalankan cubit untuk mengambil data produk
    productCubit.getProduct(tProductId);
    await tester.pumpAndSettle();

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('\$29.99'), findsOneWidget);
  });

  testWidgets('🔴 Menampilkan error jika produk gagal di-load',
      (WidgetTester tester) async {
    when(() => mockGetProductUseCase.call(param: tProductId))
        .thenAnswer((_) async => Left("Error loading product"));

    await tester.pumpWidget(createDetailProductPage());

    // Jalankan cubit untuk mengambil data produk
    productCubit.getProduct(tProductId);
    await tester.pumpAndSettle();

    expect(find.text("Error loading product"), findsOneWidget);
  });
}
