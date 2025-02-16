import 'package:dartz/dartz.dart';
import 'package:fake_store_app/common/bloc/button/cubit/button_state.dart';
import 'package:fake_store_app/core/data/models/signin_req_params.dart';
import 'package:fake_store_app/core/domain/usecases/login.dart';
import 'package:fake_store_app/services_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitial());

  Future<Either<String, String>> excute({
    required LoginUseCase usecase,
    required SigninReqParams params,
  }) async {
    emit(ButtonLoading());

    final result = await usecase.call(param: params);

    return result.fold(
      (error) {
        emit(ButtonFailure(errorMessage: error));
        return Left(error);
      },
      (token) {
        resetCubit();
        emit(ButtonSuccess());

        return Right(token);
      },
    );
  }
}
