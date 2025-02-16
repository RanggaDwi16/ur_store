import 'package:equatable/equatable.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';

abstract class AllProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AllProductsInitial extends AllProductsState {}

class AllProductsLoading extends AllProductsState {}

class AllProductsSuccess extends AllProductsState {
  final List<ProductModel> products;

  AllProductsSuccess({required this.products});

  @override
  List<Object> get props => [products];
}

class AllProductsFailure extends AllProductsState {
  final String errorMessage;

  AllProductsFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
