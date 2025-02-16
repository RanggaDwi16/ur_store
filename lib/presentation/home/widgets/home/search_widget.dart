import 'package:fake_store_app/helpers/widgets/custom_text_field.dart';
import 'package:fake_store_app/presentation/home/bloc/all_products/cubit/all_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildSearchBar(
    TextEditingController searchController, BuildContext context) {
  return SizedBox(
    height: 50,
    child: CustomTextField(
      hintText: "Search for products",
      prefixIcon: Icons.search,
      controller: searchController,
      onChanged: (value) {
        context.read<AllProductsCubit>().filterProducts(query: value);
      },
    ),
  );
}
