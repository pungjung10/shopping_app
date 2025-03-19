part of 'shopping_bloc.dart';

@immutable
abstract class ShoppingState {}

class ShoppingInitial extends ShoppingState {}

class ShoppingLoading extends ShoppingState {}

class ProductSuccess extends ShoppingState {
  final List<ProductListModel> product;

  ProductSuccess({required this.product});
}

class ProductError extends ShoppingState {}
