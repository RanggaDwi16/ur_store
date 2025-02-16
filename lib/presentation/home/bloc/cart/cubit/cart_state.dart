part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<ProductModel> cartItems;

  CartSuccess({
    required this.cartItems,
  });
}

class CartFailure extends CartState {
  final String errorMessage;

  CartFailure({
    required this.errorMessage,
  });
}
