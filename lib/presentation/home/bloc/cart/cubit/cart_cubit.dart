import 'package:bloc/bloc.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/presentation/home/data/source/home_local_service.dart';
import 'package:fake_store_app/services_locator.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final HomeLocalService homeLocalService = sl<HomeLocalService>();

  CartCubit() : super(CartInitial());

  void fetchCartItems() async {
    if (isClosed) return;

    try {
      final items = await homeLocalService.getCartItems();
      if (isClosed) return;
      final cartItems =
          items.map((item) => ProductModel.fromJson(item)).toList();

      emit(CartSuccess(cartItems: cartItems));
    } catch (e) {
      if (!isClosed) emit(CartFailure(errorMessage: e.toString()));
    }
  }

  void addToCart(ProductModel product) async {
    if (state is CartSuccess) {
      final currentState = state as CartSuccess;
      final existingIndex =
          currentState.cartItems.indexWhere((p) => p.id == product.id);

      List<ProductModel> updatedCart;
      if (existingIndex != -1) {
        updatedCart = List.from(currentState.cartItems);
        updatedCart[existingIndex] = updatedCart[existingIndex].copyWith(
          quantity: updatedCart[existingIndex].quantity! + 1,
        );
      } else {
        updatedCart = [
          ...currentState.cartItems,
          product.copyWith(quantity: 1)
        ];
      }

      emit(CartSuccess(cartItems: updatedCart));

      await homeLocalService.addToCart(product);
      fetchCartItems();
    }
  }

  void updateQuantity(int id, int quantity) async {
    if (state is CartSuccess) {
      final currentState = state as CartSuccess;
      final updatedCart = currentState.cartItems.map((item) {
        if (item.id == id) {
          return item.copyWith(quantity: quantity);
        }
        return item;
      }).toList();

      emit(CartSuccess(cartItems: updatedCart));

      await homeLocalService.updateQuantity(id, quantity);
      fetchCartItems();
    }
  }

  void removeFromCart(int id) async {
    if (state is CartSuccess) {
      final currentState = state as CartSuccess;
      final updatedCart =
          currentState.cartItems.where((item) => item.id != id).toList();

      emit(CartSuccess(cartItems: updatedCart));

      await homeLocalService.removeFromCart(id);
      fetchCartItems();
    }
  }

  void clearCart() async {
    emit(CartSuccess(cartItems: []));
    await homeLocalService.clearCart();
    fetchCartItems();
  }
}
