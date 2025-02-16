import 'package:dartz/dartz.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/presentation/home/domain/repository/home_repository.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_all_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ✅ Mock HomeRepository dengan implementasi default
class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late GetAllProductUseCase useCase;
  late MockHomeRepository mockHomeRepository;

  setUpAll(() {
    // ✅ Register fallback values untuk menghindari error
    registerFallbackValue(<ProductModel>[]);
    registerFallbackValue(ProductModel(
      id: 0,
      title: "Default",
      price: 0.0,
      description: "Default",
      category: "Default",
      image: "Default",
      rating: Rating(rate: 0.0, count: 0),
    ));
  });

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    useCase = GetAllProductUseCase(
        mockHomeRepository); // ✅ Perbaiki penggunaan dependency injection
  });

  final tProductList = [
    ProductModel(
        id: 1,
        title: "Product 1",
        price: 100,
        description: "Description 1",
        category: "Category 1",
        image: "Image 1",
        rating: Rating(rate: 4.5, count: 100)),
    ProductModel(
        id: 2,
        title: "Product 2",
        price: 200,
        description: "Description 2",
        category: "Category 2",
        image: "Image 2",
        rating: Rating(rate: 4.7, count: 200)),
  ];

  test('🔹 Harus mengembalikan daftar produk dari repository', () async {
    // ✅ Stub method dengan memastikan pemanggilan metode asli
    when(() => mockHomeRepository.getAllProducts())
        .thenAnswer((_) async => Right(tProductList));

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, Right(tProductList));
    verify(() => mockHomeRepository.getAllProducts()).called(1);
    verifyNoMoreInteractions(mockHomeRepository);
  });

  test('🔴 Harus mengembalikan error jika gagal mengambil produk', () async {
    // ✅ Stub method dengan memastikan pemanggilan metode asli
    when(() => mockHomeRepository.getAllProducts())
        .thenAnswer((_) async => Left("Error fetching products"));

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, Left("Error fetching products"));
    verify(() => mockHomeRepository.getAllProducts()).called(1);
    verifyNoMoreInteractions(mockHomeRepository);
  });
}
