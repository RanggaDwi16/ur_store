import 'package:dartz/dartz.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/presentation/home/domain/repository/home_repository.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helper.dart';

// ✅ Mock untuk HomeRepository
class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late GetProductUseCase useCase;
  late MockHomeRepository mockHomeRepository;

  setUpAll(() {
    // ✅ Register fallback values untuk menghindari error
    registerFallbackValue(1); // Fallback untuk parameter `int`
    registerFallbackValue(ProductModel(
      id: 1,
      title: "Product 1",
      price: 100,
      description: "Description 1",
      category: "Category 1",
      image: "Image 1",
      rating: Rating(rate: 4.5, count: 100),
    ));
  });

  setUp(() {
    setupTestLocator();
    mockHomeRepository = MockHomeRepository();
    useCase =
        GetProductUseCase(mockHomeRepository); // ✅ Gunakan dependency injection
  });

  const int tProductId = 1;
  final tProduct = ProductModel(
    id: 1,
    title: "Product 1",
    price: 100,
    description: "Description 1",
    category: "Category 1",
    image: "Image 1",
    rating: Rating(rate: 4.5, count: 100),
  );

  test('🔹 Harus mengembalikan produk yang sesuai dari repository', () async {
    // ✅ Pastikan stub method benar
    when(() => mockHomeRepository.getProduct(id: tProductId))
        .thenAnswer((_) async => Future.value(Right(tProduct)));

    // Act
    final result = await useCase.call(param: tProductId);

    // Assert
    expect(result, Right(tProduct)); // ✅ Gunakan `await` dalam `expect`
    verify(() => mockHomeRepository.getProduct(id: tProductId)).called(1);
    verifyNoMoreInteractions(mockHomeRepository);
  });

  test('🔴 Harus mengembalikan error jika produk tidak ditemukan', () async {
    // ✅ Simulasikan error
    when(() => mockHomeRepository.getProduct(id: any(named: 'id')))
        .thenAnswer((_) async => Future.value(Left("Product not found")));

    // Act
    final result = await useCase.call(param: tProductId);

    // Assert
    expect(
        result, Left("Product not found")); // ✅ Gunakan `await` dalam `expect`
    verify(() => mockHomeRepository.getProduct(id: tProductId)).called(1);
    verifyNoMoreInteractions(mockHomeRepository);
  });

  test('🔴 Harus mengembalikan error jika parameter ID null', () async {
    // Act
    final result = await useCase.call(param: null);

    // Assert
    expect(
        result, Left("Invalid product ID")); // ✅ Gunakan `await` dalam `expect`
  });
}
