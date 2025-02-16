import 'package:bloc_test/bloc_test.dart';
import 'package:fake_store_app/presentation/home/bloc/all_categories/cubit/all_categories_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/all_products/cubit/all_products_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/all_products/cubit/all_products_state.dart';
import 'package:fake_store_app/presentation/home/bloc/cart/cubit/cart_cubit.dart';
import 'package:fake_store_app/presentation/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ✅ Mock cubits untuk HomePage
class MockAllProductsCubit extends MockCubit<AllProductsState>
    implements AllProductsCubit {}

class MockAllCategoriesCubit extends MockCubit<AllCategoriesState>
    implements AllCategoriesCubit {}

class MockCartCubit extends MockCubit<CartState> implements CartCubit {}

void main() {
  late MockAllProductsCubit mockAllProductsCubit;
  late MockAllCategoriesCubit mockAllCategoriesCubit;
  late MockCartCubit mockCartCubit;

  setUp(() {
    mockAllProductsCubit = MockAllProductsCubit();
    mockAllCategoriesCubit = MockAllCategoriesCubit();
    mockCartCubit = MockCartCubit();
  });

  Widget createHomePage() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllProductsCubit>.value(value: mockAllProductsCubit),
        BlocProvider<AllCategoriesCubit>.value(value: mockAllCategoriesCubit),
        BlocProvider<CartCubit>.value(value: mockCartCubit),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }

  testWidgets('✅ Menampilkan judul halaman HomePage dengan benar',
      (WidgetTester tester) async {
    await tester.pumpWidget(createHomePage());

    expect(find.text('What are you looking for today?'), findsOneWidget);
  });

  testWidgets('✅ Memastikan kategori ditampilkan', (WidgetTester tester) async {
    when(() => mockAllCategoriesCubit.state).thenReturn(
        AllCategoriesSuccess(categories: ["Electronics", "Men's Clothing"]));

    await tester.pumpWidget(createHomePage());

    expect(find.text('Electronics'), findsOneWidget);
    expect(find.text("Men's Clothing"), findsOneWidget);
  });

  testWidgets('🔴 Menampilkan error jika produk gagal dimuat',
      (WidgetTester tester) async {
    when(() => mockAllProductsCubit.state).thenReturn(
        AllProductsFailure(errorMessage: "Error fetching products"));

    await tester.pumpWidget(createHomePage());

    expect(find.text("Error fetching products"), findsOneWidget);
  });
}
