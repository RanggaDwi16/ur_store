import 'package:fake_store_app/presentation/home/widgets/cart/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store_app/presentation/home/bloc/cart/cubit/cart_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..fetchCartItems(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: const Text("Shopping Cart"),
          actions: [
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<CartCubit>().clearCart();
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartFailure) {
              return Center(child: Text("Error: ${state.errorMessage}"));
            }
            if (state is CartSuccess) {
              return state.cartItems.isEmpty
                  ? const Center(child: Text("Cart is Empty"))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.cartItems.length,
                            itemBuilder: (context, index) {
                              final item = state.cartItems[index];
                              return buildCartItem(context, item);
                            },
                          ),
                        ),
                        buildCartSummary(context, state),
                      ],
                    );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
