import 'package:fake_store_app/core/domain/repository/auth_repository.dart';
import 'package:fake_store_app/core/domain/usecases/is_logged_in.dart';
import 'package:fake_store_app/services_locator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ✅ Mock untuk AuthRepository
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late IsLoggedInUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    sl.registerSingleton<AuthRepository>(mockAuthRepository);
    useCase = IsLoggedInUseCase();
  });

  tearDown(() {
    sl.reset();
  });

  test('🔹 Harus mengembalikan true jika pengguna sudah login', () async {
    // ✅ Pastikan return `Future.value(true)`
    when(() => mockAuthRepository.isLoggedIn())
        .thenAnswer((_) async => Future.value(true));

    final result = await useCase.call();

    expect(result, true);
    verify(() => mockAuthRepository.isLoggedIn()).called(1);
  });

  test('🔴 Harus mengembalikan false jika pengguna belum login', () async {
    // ✅ Pastikan return `Future.value(false)`
    when(() => mockAuthRepository.isLoggedIn())
        .thenAnswer((_) async => Future.value(false));

    final result = await useCase.call();

    expect(result, false);
    verify(() => mockAuthRepository.isLoggedIn()).called(1);
  });
}
