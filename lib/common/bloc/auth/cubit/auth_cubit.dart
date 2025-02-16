import 'package:bloc/bloc.dart';
import 'package:fake_store_app/common/bloc/auth/cubit/auth_state.dart';
import 'package:fake_store_app/core/domain/usecases/is_logged_in.dart';
import 'package:fake_store_app/services_locator.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AppInitialState());

  void appStarted() async {
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    print('isLoggedIn: $isLoggedIn');
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
