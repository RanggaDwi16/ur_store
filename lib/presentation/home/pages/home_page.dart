import 'package:fake_store_app/core/configs/app_theme.dart';
import 'package:fake_store_app/presentation/home/bloc/all_categories/selected_category_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/cart/cubit/cart_cubit.dart';
import 'package:fake_store_app/presentation/home/widgets/home/app_bar_widget.dart';
import 'package:fake_store_app/presentation/home/widgets/home/category_widget.dart';
import 'package:fake_store_app/presentation/home/widgets/home/product_widget.dart';
import 'package:fake_store_app/presentation/home/widgets/home/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store_app/presentation/home/bloc/all_categories/cubit/all_categories_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/all_products/cubit/all_products_cubit.dart';
import 'package:fake_store_app/services_locator.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SelectedCategoryCubit>()),
        BlocProvider(
            create: (context) => sl<AllProductsCubit>()..getAllProducts()),
        BlocProvider(
            create: (context) => sl<AllCategoriesCubit>()..getAllCategories()),
        BlocProvider(create: (context) => sl<CartCubit>()..fetchCartItems()),
      ],
      child: const HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    searchController.clear();
    context.read<SelectedCategoryCubit>().selectCategory("All Category");
    context.read<AllProductsCubit>().getAllProducts();
    context.read<AllCategoriesCubit>().getAllCategories();
    context.read<CartCubit>().fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<SelectedCategoryCubit>(),
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartSuccess) {
            sl<CartCubit>().fetchCartItems();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          body: RefreshIndicator(
            color: AppTheme.appTheme.primaryColor,
            onRefresh: _refresh,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi,',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'What are you looking for today?',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Gap(10),
                  buildSearchBar(searchController, context),
                  Gap(10),
                  buildCategoriesSection(searchController),
                  Expanded(child: buildProductsSection()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
