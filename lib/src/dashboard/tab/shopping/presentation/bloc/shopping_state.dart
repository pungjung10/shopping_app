part of 'shopping_bloc.dart';

@immutable
abstract class ShoppingState {}

class ShoppingInitial extends ShoppingState {}

class ShoppingLoading extends ShoppingState {}

class ShoppingSuccess extends ShoppingState {

}

class ShoppingError extends ShoppingState {}
