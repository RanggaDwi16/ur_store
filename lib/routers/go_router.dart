import 'package:fake_store_app/core/domain/usecases/is_logged_in.dart';
import 'package:fake_store_app/presentation/auth/pages/login_page.dart';
import 'package:fake_store_app/routers/router_name.dart';
import 'package:fake_store_app/services_locator.dart';
import 'package:go_router/go_router.dart';
import 'package:fake_store_app/presentation/home/pages/home_page.dart';
import 'package:fake_store_app/presentation/home/pages/detail_product_page.dart';
import 'package:fake_store_app/presentation/home/pages/cart_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      name: '/',
      path: RouterName.login,
      builder: (context, state) => const LoginPage(),
      redirect: (context, state) async {
        final isLoggedIn = await sl<IsLoggedInUseCase>().call();
        print('isLoggedIn: $isLoggedIn');
        return isLoggedIn ? RouterName.home : RouterName.login;
      },
    ),
    GoRoute(
      name: '/home',
      path: RouterName.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: '/detail-product',
      path: RouterName.detailProduct,
      builder: (context, state) {
        final productId = state.extra as int;
        return DetailProductPage(productId: productId);
      },
    ),
    GoRoute(
      name: '/cart',
      path: RouterName.cart,
      builder: (context, state) => const CartPage(),
    ),
  ],
);
