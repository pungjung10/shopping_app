part of 'product_bloc.dart';

@immutable
class ProductState {
  final Map<String, int> items;

  const ProductState(this.items);
}
