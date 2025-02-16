import 'package:fake_store_app/presentation/home/bloc/all_products/cubit/all_products_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/all_products/cubit/all_products_state.dart';
import 'package:fake_store_app/presentation/home/data/models/product_model.dart';
import 'package:fake_store_app/routers/router_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

Widget buildProductsSection() {
  return BlocBuilder<AllProductsCubit, AllProductsState>(
    builder: (context, state) {
      if (state is AllProductsLoading) return _buildShimmerEffect();
      if (state is AllProductsFailure) Center(child: Text(state.errorMessage));
      if (state is AllProductsSuccess) return _buildProductList(state.products);
      return const Center(child: Text("No Products Found"));
    },
  );
}

Widget _buildProductList(List<ProductModel> products) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemCount: products.length,
    itemBuilder: (context, index) {
      final product = products[index];
      return GestureDetector(
        onTap: () async {
          context.pushNamed(
            RouterName.detailProduct,
            extra: product.id,
          );
        },
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(product.image ?? "",
                      width: double.infinity, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title ?? "No Title",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w400)),
                    const Gap(5),
                    Text("USD ${product.price?.toStringAsFixed(2) ?? "0.00"}",
                        style: const TextStyle(fontWeight: FontWeight.w400)),
                    Gap(10),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                        Text(product.rating?.rate?.toStringAsFixed(1) ?? "0.0",
                            style: const TextStyle(color: Colors.grey)),
                        const Gap(8),
                        Text("${product.rating?.count ?? 0} Reviews",
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildShimmerEffect() {
  return GridView.builder(
    padding: const EdgeInsets.all(10),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemCount: 6, 
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white, 
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: double.infinity,
                      color: Colors.white, 
                    ),
                    const Gap(8),
                    Container(
                      height: 14,
                      width: 80,
                      color: Colors.white, 
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        Container(
                          height: 14,
                          width: 50,
                          color: Colors.white, 
                        ),
                        const Gap(10),
                        Container(
                          height: 14,
                          width: 50,
                          color: Colors.white, 
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
