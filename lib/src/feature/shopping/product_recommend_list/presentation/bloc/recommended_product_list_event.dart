part of 'product_list_bloc.dart';

@immutable
abstract class ProductListEvent {}

class ProductListLoadData extends ProductListEvent {

  ProductListLoadData();
}