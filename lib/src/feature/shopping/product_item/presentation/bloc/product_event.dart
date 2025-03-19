part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class AddItemEvent extends ProductEvent {
  final String product;

  AddItemEvent(this.product);
}

class RemoveItemEvent extends ProductEvent {
  final String product;

  RemoveItemEvent(this.product);
}