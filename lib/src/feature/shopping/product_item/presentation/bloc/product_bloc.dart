import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  ProductBloc() : super(const ProductState({})) {
    on<AddItemEvent>((event, emit) async {
      final items = Map<String, int>.from(state.items);
      items[event.product] = (items[event.product] ?? 0) + 1;
      emit(ProductState(items));
    });

    on<RemoveItemEvent>((event, emit) async {
      final items = Map<String, int>.from(state.items);
      if (items.containsKey(event.product) && (items[event.product] ?? 0) > 0) {
        items[event.product] = (items[event.product] ?? 0) - 1;
        if (items[event.product] == 0) {
          items.remove(event.product);
        }
      }
      emit(ProductState(items));
    });
  }
}