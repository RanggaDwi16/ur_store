import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:fake_store_app/presentation/home/bloc/cart/cubit/cart_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/product/cubit/product_state.dart';
import 'package:fake_store_app/presentation/home/data/source/home_local_service.dart';
import 'package:fake_store_app/presentation/home/domain/usecase/get_product.dart';
import 'package:fake_store_app/presentation/home/widgets/detail_product/detail_product_widget.dart';
import 'package:fake_store_app/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store_app/presentation/home/bloc/product/cubit/product_cubit.dart';

class DetailProductPage extends StatelessWidget {
  final int productId;

  const DetailProductPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  ProductCubit(sl<GetProductUseCase>())..getProduct(productId),
            ),
            BlocProvider(
              create: (context) => CartCubit(),
            ),
          ],
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return buildShimmerLoading();
              }
              if (state is ProductFailure) {
                return Center(child: Text("Error: ////${state.errorMessage}"));
              }
              if (state is ProductSuccess) {
                return buildProductDetail(context, state.product);
              }
              return const Center(child: Text("No Product Found"));
            },
          ),
        ),
      ),
    );
  }
}
