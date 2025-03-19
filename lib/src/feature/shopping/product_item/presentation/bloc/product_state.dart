part of 'product_bloc.dart';

@immutable
class ProductState {
  final Map<ItemModel, int> items;

  const ProductState(this.items);
}
