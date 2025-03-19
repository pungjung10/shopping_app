part of 'shopping_bloc.dart';

@immutable
abstract class ShoppingEvent {}

class ProductLoadData extends ShoppingEvent {

  ProductLoadData();
}