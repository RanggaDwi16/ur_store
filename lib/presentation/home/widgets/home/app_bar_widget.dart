import 'package:fake_store_app/core/configs/app_theme.dart';
import 'package:fake_store_app/core/data/source/auth_local_service.dart';
import 'package:fake_store_app/presentation/home/bloc/cart/cubit/cart_cubit.dart';
import 'package:fake_store_app/routers/router_name.dart';
import 'package:fake_store_app/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0,
    title: Image.asset("assets/images/logo_store.png", width: 150),
    leading: IconButton(
      icon: Icon(
        Icons.account_circle_rounded,
        size: 30,
        color: AppTheme.appTheme.primaryColor,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final result = await sl<AuthLocalService>().logout();
                    result.fold(
                        (l) => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l.message)),
                            ), (r) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logout success')),
                      );
                      context.go(RouterName.login);
                    });
                  },
                  child: const Text('Logout'),
                ),
              ],
            );
          },
        );
      },
    ),
    actions: [
      BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          int cartItemCount = 0;

          if (state is CartSuccess) {
            cartItemCount = state.cartItems.length;
          }

          return Stack(children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                context.pushNamed(RouterName.cart);
              },
            ),
            Positioned(
              right: 11,
              bottom: 11,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(6)),
                constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                child: Text('$cartItemCount',
                    style: const TextStyle(color: Colors.white, fontSize: 8),
                    textAlign: TextAlign.center),
              ),
            )
          ]);
        },
      ),
    ],
  );
}
