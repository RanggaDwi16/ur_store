import 'package:dartz/dartz.dart';
import 'package:fake_store_app/core/domain/repository/auth_repository.dart';
import 'package:fake_store_app/core/domain/usecases/logout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helper.dart';

// ✅ Mock untuk AuthRepository
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LogoutUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    setupTestLocator();
    mockAuthRepository = MockAuthRepository();
    useCase = LogoutUseCase(mockAuthRepository);
  });

  final tSuccessResponse = Right("Logout Berhasil");

  test('🔹 Harus mengembalikan Right jika logout berhasil', () async {
    // Arrange
    when(() => mockAuthRepository.logout())
        .thenAnswer((_) async => tSuccessResponse);

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, tSuccessResponse);
    verify(() => mockAuthRepository.logout()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('🔴 Harus mengembalikan Left jika logout gagal', () async {
    // Arrange
    when(() => mockAuthRepository.logout())
        .thenAnswer((_) async => Left("Error Logout"));

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, Left("Error Logout"));
    verify(() => mockAuthRepository.logout()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
