import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/product_model.dart';
import 'package:shopping_app/src/feature/shopping/product_list/domain/usecase/get_product_usecase.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductUseCase _getProductUseCase;

  String cursor = "";
  bool _isLoadMore = true;

  ProductListBloc(this._getProductUseCase) : super(ProductListInitial()) {
    on<ProductListLoadData>((event, emit) async {
      emit(ProductListLoading());
      final result = await _getProductUseCase.execute(20, cursor);
      result.fold((e) {
        emit(ProductListError());
      }, (res) {
        cursor = Uri.encodeComponent(res.cursor);
        emit(ProductListSuccess(product: res));
      });
    });

    on<ProductListLoadMoreData>((event, emit) async {
      if (state is ProductListSuccess && _isLoadMore) {
        _isLoadMore = false;
        final currentState = state as ProductListSuccess;
        final result = await _getProductUseCase.execute(20, cursor);
        result.fold((e) {
          _isLoadMore = true;
          emit(ProductListError());
        }, (res) {
          _isLoadMore = true;
          cursor = Uri.encodeComponent(res.cursor);
          final updatedProductList = currentState.product.copyWith(
            items: [...currentState.product.items, ...res.items],
            cursor: res.cursor,
          );

          emit(ProductListSuccess(product: updatedProductList));
        });
      }
    });
  }
}
