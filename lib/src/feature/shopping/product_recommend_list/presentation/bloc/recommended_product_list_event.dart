part of 'recommended_product_list_bloc.dart';

@immutable
abstract class RecommendedProductListEvent {}

class RecommendedProductListLoadData extends RecommendedProductListEvent {

  RecommendedProductListLoadData();
}