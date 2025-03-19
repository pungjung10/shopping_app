import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/item_model.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<Map<ItemModel, int>> productList = [];

  ProductBloc() : super(const ProductState({})) {
    on<AddItemEvent>((event, emit) async {
      bool updated = false;

      for (var items in productList) {
        if (items.containsKey(event.product)) {
          items[event.product] = items[event.product]! + 1;
          updated = true;
          break;
        }
      }

      if (!updated) {
        productList.add({event.product: 1});
      }

      emit(ProductState(_mergeProductList()));
    });

    on<RemoveItemEvent>((event, emit) async {
      for (var items in productList) {
        if (items.containsKey(event.product)) {
          items[event.product] = items[event.product]! - 1;

          if (items[event.product] == 0) {
            items.remove(event.product);
          }

          if (items.isEmpty) {
            productList.remove(items);
          }
          break;
        }
      }

      emit(ProductState(_mergeProductList()));
    });

    on<ClearItemEvent>((event, emit) async {
      for (var items in productList) {
        if (items.containsKey(event.product)) {
          items.remove(event.product);
          productList.remove(items);
          break;
        }
      }
      emit(ProductState(_mergeProductList()));
    });

    on<ClearAllItemEvent>((event, emit) async {
      productList.clear();
      emit(ProductState(_mergeProductList()));
    });
  }

  Map<ItemModel, int> _mergeProductList() {
    final merged = <ItemModel, int>{};

    for (var items in productList) {
      for (var entry in items.entries) {
        merged[entry.key] = (merged[entry.key] ?? 0) + entry.value;
      }
    }

    return merged;
  }
}