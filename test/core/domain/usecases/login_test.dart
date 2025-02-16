import 'package:dartz/dartz.dart';
import 'package:fake_store_app/core/data/models/signin_req_params.dart';
import 'package:fake_store_app/core/domain/repository/auth_repository.dart';
import 'package:fake_store_app/core/domain/usecases/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helper.dart';

// ✅ Mock AuthRepository
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUpAll(() {
    // 🔹 Tambahkan registerFallbackValue untuk menghindari error Mocktail
    registerFallbackValue(
        SigninReqParams(username: "dummy", password: "dummy"));
  });

  setUp(() {
    setupTestLocator();
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase( mockAuthRepository);
  });

  final tSigninReqParams =
      SigninReqParams(username: "mor_2314", password: "83r5^_");
  final Either<String, String> tSuccessResponse = Right("Login Berhasil");
  final Either<String, String> tFailureResponse = Left("Error Login");

  test('🔹 Harus mengembalikan Right jika login berhasil', () async {
    // Arrange
    when(() => mockAuthRepository.login(any()))
        .thenAnswer((_) async => tSuccessResponse);

    // Act
    final result = await useCase.call(param: tSigninReqParams);

    // Assert
    expect(result, equals(tSuccessResponse));
    verify(() => mockAuthRepository.login(tSigninReqParams)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('🔴 Harus mengembalikan Left jika login gagal', () async {
    // Arrange
    when(() => mockAuthRepository.login(any()))
        .thenAnswer((_) async => tFailureResponse);

    // Act
    final result = await useCase.call(param: tSigninReqParams);

    // Assert
    expect(result, equals(tFailureResponse));
    verify(() => mockAuthRepository.login(tSigninReqParams)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
