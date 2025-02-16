import 'package:bloc/bloc.dart';
import 'package:fake_store_app/presentation/home/bloc/product/cubit/product_state.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_product.dart';


class ProductCubit extends Cubit<ProductState> {
  final GetProductUseCase usecase;
  ProductCubit(
    this.usecase,
  ) : super(ProductInitial());

  void getProduct(int id) async {
    emit(ProductLoading()); // 🔹 Hapus ProductInitial

    final result = await usecase.call(param: id);
    result.fold(
      (error) => emit(ProductFailure(errorMessage: error)),
      (product) => emit(ProductSuccess(product: product)),
    );
  }
}
