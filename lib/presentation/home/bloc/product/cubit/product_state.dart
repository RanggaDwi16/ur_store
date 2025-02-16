import 'package:equatable/equatable.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';


abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final ProductModel product;

  ProductSuccess({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductFailure extends ProductState {
  final String errorMessage;

  ProductFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
