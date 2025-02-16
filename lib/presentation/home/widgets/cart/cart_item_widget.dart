import 'package:fake_store_app/core/configs/app_theme.dart';
import 'package:fake_store_app/presentation/home/bloc/cart/cubit/cart_cubit.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

Widget buildCartItem(BuildContext context, ProductModel item) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 100, 
                height: 140, 
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item.image!),
                    fit: BoxFit.cover, 
                  ),
                ),
              ),
            ),
            Gap(16), 

            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gap(5),
                  Text(
                    "USD ${item.price?.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        color: AppTheme.appTheme.primaryColor,
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (item.quantity! > 1) {
                            context
                                .read<CartCubit>()
                                .updateQuantity(item.id!, item.quantity! - 1);
                          } else {
                            context.read<CartCubit>().removeFromCart(item.id!);
                          }
                        },
                      ),
                      Text(
                        "${item.quantity}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                        color: AppTheme.appTheme.primaryColor,
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          context
                              .read<CartCubit>()
                              .updateQuantity(item.id!, item.quantity! + 1);
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<CartCubit>().removeFromCart(item.id!);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartSummary(BuildContext context, CartSuccess state) {
    double totalPrice = state.cartItems
        .fold(0, (sum, item) => sum + (item.price! * item.quantity!));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total ${state.cartItems.length} Items",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text("USD ${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          Gap(12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.appTheme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      "Proceed to Checkout",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }