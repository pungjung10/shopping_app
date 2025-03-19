import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/dashboard/tab/cart/domain/model/summary_model.dart';
import 'package:shopping_app/src/dashboard/tab/cart/domain/usecase/calculate_total_price_usecase.dart';

import '../../../shopping/domain/model/item_model.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CalculateTotalPriceUseCase _calculateTotalPriceUseCase;

  CartBloc(this._calculateTotalPriceUseCase) : super(CartInitial()) {
    on<UpdateCart>((event, emit) async {
      final result =
          await _calculateTotalPriceUseCase.execute(event.productList);
      if (event.productList.isNotEmpty) {
        emit(CartUpdated(productList: event.productList, summary: result));
      } else {
        emit(CartEmpty());
      }
    });
  }
}
