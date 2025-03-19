import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/item_model.dart';
import 'package:shopping_app/src/feature/shopping/product_recommend_list/domain/get_recommended_product_usecase.dart';

part 'recommended_product_list_event.dart';

part 'recommended_product_list_state.dart';

class RecommendedProductListBloc extends Bloc<RecommendedProductListEvent, RecommendedProductListState> {
  final GetRecommendedProductUseCase _getRecommendedProductUseCase;

  RecommendedProductListBloc(this._getRecommendedProductUseCase) : super(RecommendedProductListInitial()) {
    on<RecommendedProductListLoadData>((event, emit) async {
      emit(RecommendedProductListLoading());
      final result = await _getRecommendedProductUseCase.execute();
      result.fold((e) {
        emit(RecommendedProductListError());
      }, (res) {
        emit(RecommendProductListSuccess(product: res));
      });
    });
  }
}