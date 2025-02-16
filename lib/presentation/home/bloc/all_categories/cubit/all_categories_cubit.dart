import 'package:bloc/bloc.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_all_category.dart';

part 'all_categories_state.dart';

class AllCategoriesCubit extends Cubit<AllCategoriesState> {
  final GetAllCategoryUseCase getAllCategoryUseCase;

  AllCategoriesCubit(this.getAllCategoryUseCase)
      : super(AllCategoriesInitial());

  void getAllCategories() async {
    if (isClosed) return; // ✅ Pastikan cubit belum ditutup
    emit(AllCategoriesLoading());
    final result = await getAllCategoryUseCase.call();

    if (isClosed) return; // ✅ Pastikan cubit belum ditutup

    result.fold(
      (errorMessage) {
        if (isClosed) return; // ✅ Pastikan cubit belum ditutup
        emit(AllCategoriesFailure(errorMessage: errorMessage));
      },
      (categories) {
        if (isClosed) return; // ✅ Pastikan cubit belum ditutup
        emit(AllCategoriesSuccess(categories: categories));
      },
    );
  }
}
