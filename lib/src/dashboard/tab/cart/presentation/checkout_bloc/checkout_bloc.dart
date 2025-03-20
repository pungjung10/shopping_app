import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/model/product_request.dart';
import 'package:shopping_app/src/dashboard/tab/cart/domain/usecase/checkout_usecase.dart';


part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckOutUseCase _checkOutUseCase;

  CheckoutBloc(this._checkOutUseCase) : super(CheckoutInitial()) {

    on<CheckOut>((event, emit) async {
      final result = await _checkOutUseCase.execute(event.product);
      result.fold((e) {
        emit(CheckoutError());
      }, (res) {
        emit(CheckoutSuccess());
      });
    });

  }
}
