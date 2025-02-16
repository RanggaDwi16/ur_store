import 'package:bloc_test/bloc_test.dart';
import 'package:fake_store_app/presentation/home/bloc/cart/cubit/cart_cubit.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/presentation/home/data/source/home_local_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helper.dart';

// ✅ Mock HomeLocalService
class MockHomeLocalService extends Mock implements HomeLocalService {}

void main() {
  late CartCubit cubit;
  late MockHomeLocalService mockLocalService;

  setUpAll(() {
    // 🔹 Register fallback value untuk `ProductModel`
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
    setupTestLocator();
    mockLocalService = MockHomeLocalService();
    cubit = CartCubit();
  });

  tearDown(() {
    cubit.close();
  });

  final tProduct = ProductModel(id: 1, title: "Product 1", price: 100);

  blocTest<CartCubit, CartState>(
    '🔹 Harus mengeluarkan [CartLoading, CartSuccess] ketika item ditambahkan ke cart',
    build: () {
      when(() => mockLocalService.getCartItems())
          .thenAnswer((_) async => []); // ✅ Pastikan return tidak null

      when(() => mockLocalService.addToCart(any()))
          .thenAnswer((_) async {}); // ✅ Simulasi sukses menambah item

      return CartCubit();
    },
    act: (cubit) async {
      cubit.fetchCartItems(); // ✅ Pastikan `CartSuccess` diemit dulu
      cubit.addToCart(tProduct);
    },
    expect: () => [
      CartSuccess(cartItems: []), // ✅ State awal `CartSuccess`
      CartSuccess(
          cartItems: [tProduct.copyWith(quantity: 1)]), // ✅ Produk ditambahkan
    ],
    verify: (_) {
      verify(() => mockLocalService.getCartItems()).called(1);
      verify(() => mockLocalService.addToCart(any())).called(1);
    },
  );

  blocTest<CartCubit, CartState>(
    '🔴 Harus mengeluarkan [CartFailure] jika terjadi error saat fetch cart',
    build: () {
      when(() => mockLocalService.getCartItems())
          .thenThrow(Exception("Error fetching cart"));
      return cubit;
    },
    act: (cubit) => cubit.fetchCartItems(),
    expect: () => [
      CartFailure(errorMessage: "Exception: Error fetching cart"),
    ],
  );
}
