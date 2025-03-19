part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class UpdateCart extends CartEvent {
  final List<Map<ItemModel, int>> productList;

  UpdateCart(this.productList);
}

class CalculateTotalPrice extends CartEvent {
  final List<Map<ItemModel, int>> productList;

  CalculateTotalPrice(this.productList);
}