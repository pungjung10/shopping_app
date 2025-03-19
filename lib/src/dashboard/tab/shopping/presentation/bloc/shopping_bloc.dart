import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/product_model.dart';
import 'package:shopping_app/src/feature/shopping/product_list/domain/usecase/get_product_usecase.dart';

part 'shopping_event.dart';

part 'shopping_state.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  final GetProductUseCase _getProductUseCase;

  ShoppingBloc(this._getProductUseCase) : super(ShoppingInitial()) {
    on<ProductLoadData>((event, emit) async {});
  }
}
