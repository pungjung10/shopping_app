part of 'recommended_product_list_bloc.dart';

@immutable
abstract class RecommendedProductListState {}

class RecommendedProductListInitial extends RecommendedProductListState {}

class RecommendedProductListLoading extends RecommendedProductListState {}

class RecommendProductListSuccess extends RecommendedProductListState {
  final List<ItemModel> product;

  RecommendProductListSuccess({required this.product});
}

class RecommendedProductListError extends RecommendedProductListState {}