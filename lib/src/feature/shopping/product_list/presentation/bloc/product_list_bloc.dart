import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/product_model.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/usecase/get_product_usecase.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductUseCase _getProductUseCase;

  ProductListBloc(this._getProductUseCase) : super(ProductListInitial()) {
    on<ProductListLoadData>((event, emit) async {
      emit(ProductListLoading());
      final result = await _getProductUseCase.execute();
      result.fold((e) {
        emit(ProductListError());
      }, (res) {
        emit(ProductListSuccess(product: res));
      });
    });
  }
}