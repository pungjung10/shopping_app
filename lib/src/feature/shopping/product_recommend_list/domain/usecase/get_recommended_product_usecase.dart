import 'package:dartz/dartz.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/item_response.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/shopping_repository.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/item_model.dart';

import '../../../../../core/base/failure.dart';

abstract class GetRecommendedProductUseCase {
  Future<Either<Failure, List<ItemModel>>> execute();
}

class GetRecommendedProductUseCaseImpl implements GetRecommendedProductUseCase {
  final ShoppingRepository repository;

  GetRecommendedProductUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<ItemModel>>> execute() async {
    final response = await repository.getRecommendedProduct();
    return response.map((res) => res?.map((item) => _toItemModel(item)).toList() ?? []) ;
  }

  ItemModel _toItemModel(ItemResponse? data) {
    return ItemModel(data?.id ?? -1, data?.name ?? "", data?.price ?? 0);
  }
}
