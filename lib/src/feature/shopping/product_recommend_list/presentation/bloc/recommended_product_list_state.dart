part of 'product_list_bloc.dart';

@immutable
abstract class ProductListState {}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListSuccess extends ProductListState {
  final ProductListModel product;

  ProductListSuccess({required this.product});
}

class ProductListError extends ProductListState {}