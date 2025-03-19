part of 'product_list_bloc.dart';

@immutable
abstract class ProductListEvent {}

class ProductListLoadData extends ProductListEvent {
  final String cursor;

  ProductListLoadData(this.cursor);
}

class ProductListLoadMoreData extends ProductListEvent {
  final String cursor;

  ProductListLoadMoreData(this.cursor);
}