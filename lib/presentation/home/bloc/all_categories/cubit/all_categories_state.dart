part of 'all_categories_cubit.dart';

abstract class AllCategoriesState {}

class AllCategoriesInitial extends AllCategoriesState {}

class AllCategoriesLoading extends AllCategoriesState {}

class AllCategoriesSuccess extends AllCategoriesState {
  final List<String> categories;

  AllCategoriesSuccess({
    required this.categories,
  });
}

class AllCategoriesFailure extends AllCategoriesState {
  final String errorMessage;

  AllCategoriesFailure({
    required this.errorMessage,
  });
}