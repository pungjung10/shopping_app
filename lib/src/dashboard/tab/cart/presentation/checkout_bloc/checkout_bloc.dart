import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/model/product_request.dart';
import 'package:shopping_app/src/dashboard/tab/cart/domain/usecase/check_out_usecase.dart';


part 'check_out_event.dart';

part 'check_out_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  final CheckOutUseCase _checkOutUseCase;

  CheckOutBloc(this._checkOutUseCase) : super(CheckOutInitial()) {

    on<CheckOut>((event, emit) async {
      final result = await _checkOutUseCase.execute(event.product);
      result.fold((e) {
        emit(CheckOutError());
      }, (res) {
        emit(CheckOutSuccess());
      });

    });
  }
}
