import 'package:bloc/bloc.dart';
import 'package:fake_store_app/presentation/home/bloc/all_products/cubit/all_products_state.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_all_product.dart';
import 'package:fake_store_app/services_locator.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  final GetAllProductUseCase usecase;
  List<ProductModel> allProducts = [];

  AllProductsCubit({required this.usecase}) : super(AllProductsInitial());

  void getAllProducts() async {
    if (isClosed) return; // ✅ Pastikan cubit belum ditutup
    emit(AllProductsLoading());
    final result = await usecase.call();

    result.fold(
      (error) => emit(AllProductsFailure(errorMessage: error)),
      (products) {
        allProducts = products;
        emit(AllProductsSuccess(products: products));
      },
    );
  }

  void filterProducts({String query = "", String category = "All Category"}) {
    if (isClosed) return; // ✅ Pastikan cubit belum ditutup

    List<ProductModel> filteredProducts = allProducts;

    if (category != "All Category") {
      filteredProducts = filteredProducts
          .where((product) => product.category == category)
          .toList();
    }

    if (query.isNotEmpty) {
      filteredProducts = filteredProducts
          .where((product) =>
              product.title?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    }

    if (filteredProducts.isEmpty) {
      emit(AllProductsFailure(errorMessage: "No Product Found"));
      return;
    }

    emit(AllProductsSuccess(products: filteredProducts));
  }
}
