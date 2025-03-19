part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<Map<ItemModel, int>> productList;
  final SummaryModel summary;

  CartUpdated({required this.productList, required this.summary});
}

class CartEmpty extends CartState {}
