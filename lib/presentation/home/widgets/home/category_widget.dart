import 'package:fake_store_app/core/configs/app_theme.dart';
import 'package:fake_store_app/presentation/home/bloc/all_categories/cubit/all_categories_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/all_categories/selected_category_cubit.dart';
import 'package:fake_store_app/presentation/home/bloc/all_products/cubit/all_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

Widget buildCategoriesSection(TextEditingController searchController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Categories',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      BlocBuilder<AllCategoriesCubit, AllCategoriesState>(
        builder: (context, state) {
          if (state is AllCategoriesLoading) {
            return _buildShimmerCategory(); 
          }
          if (state is AllCategoriesFailure) {
            return Center(child: Text("Error: ${state.errorMessage}"));
          }
          if (state is AllCategoriesSuccess) {
            return _buildCategoryList(
                state.categories, context, searchController);
          }
          return const Center(child: Text("No Categories Found"));
        },
      ),
    ],
  );
}


Widget _buildShimmerCategory() {
  return SizedBox(
    height: 50,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5, 
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildCategoryList(List<String> categories, BuildContext context,
    TextEditingController searchController) {
  final List<String> allCategories = ["All Category", ...categories];
  return BlocBuilder<SelectedCategoryCubit, String>(
    builder: (context, selectedCategory) {
      return SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: allCategories.length,
          itemBuilder: (context, index) {
            final isSelected = selectedCategory == allCategories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: GestureDetector(
                onTap: () {
                  print("🔄 Selecting category: ${allCategories[index]}");
                  context
                      .read<SelectedCategoryCubit>()
                      .selectCategory(allCategories[index]);

                  print(
                      "🛒 Filtering products with category: ${allCategories[index]}");
                  context.read<AllProductsCubit>().filterProducts(
                        category: allCategories[index],
                        query: searchController.text,
                      );
                },
                child: Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                        color: isSelected
                            ? AppTheme.appTheme.primaryColor
                            : Colors.black),
                  ),
                  label: Text(allCategories[index]),
                  backgroundColor: isSelected
                      ? AppTheme.appTheme.primaryColor
                      : Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
