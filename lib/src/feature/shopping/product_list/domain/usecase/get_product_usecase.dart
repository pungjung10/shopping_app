import 'package:dartz/dartz.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/item_response.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/product_response.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/shopping_repository.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/item_model.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/product_model.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/shopping_data.dart';

import '../../../../../core/base/failure.dart';

abstract class GetProductUseCase {
  Future<Either<Failure, ProductListModel>> execute();
}

class GetProductUseCaseImpl implements GetProductUseCase {
  final ShoppingRepository repository;

  GetProductUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, ProductListModel>> execute() async {
    final response = await repository.getProduct();
    return response.map((res) => _toProductListModel(res));
  }

  ProductListModel _toProductListModel(ProductResponse? data) {
    return ProductListModel(
        data?.items?.map((item) => _toItemModel(item)).toList() ?? [],
        ProductType.products);
  }

  ItemModel _toItemModel(ItemResponse? data) {
    return ItemModel(data?.id ?? -1, data?.name ?? "", data?.price ?? 0);
  }
}
