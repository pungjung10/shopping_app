part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class AddItemEvent extends ProductEvent {
  final ItemModel product;

  AddItemEvent(this.product);
}

class RemoveItemEvent extends ProductEvent {
  final ItemModel product;

  RemoveItemEvent(this.product);
}

class ClearItemEvent extends ProductEvent {
  final ItemModel product;

  ClearItemEvent(this.product);
}