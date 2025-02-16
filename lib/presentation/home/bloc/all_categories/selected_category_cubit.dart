import 'package:bloc/bloc.dart';

class SelectedCategoryCubit extends Cubit<String> {
  SelectedCategoryCubit() : super("All Category");

  void selectCategory(String category) {
    if (!isClosed) {
      // ✅ Pastikan Cubit masih aktif sebelum mengupdate state
      emit(category);
    }
  }
}
