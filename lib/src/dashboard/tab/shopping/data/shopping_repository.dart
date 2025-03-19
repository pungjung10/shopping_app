import 'package:dartz/dartz.dart';
import 'package:shopping_app/src/core/base/failure.dart';
import 'package:shopping_app/src/core/network/network_extension.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/item_response.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/product_response.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/remote/shopping_service.dart';

abstract class ShoppingRepository {
  Future<Either<Failure, ProductResponse?>> getProduct(int limit, String cursor);
  Future<Either<Failure, List<ItemResponse>?>> getRecommendedProduct();
}

class ShoppingRepositoryImpl implements ShoppingRepository {
  final ShoppingService _service;

  ShoppingRepositoryImpl(this._service);

  @override
  Future<Either<Failure, ProductResponse?>> getProduct(int limit, String cursor) async {
    return NetworkExtension.call(
        onCall: () => _service.getProduct(limit, cursor),
        onSuccess: (r) {
          return Right(r);
        },
        onFailure: (l) {
          return Left(l);
        });
  }

  @override
  Future<Either<Failure, List<ItemResponse>?>> getRecommendedProduct() async {
    return NetworkExtension.call(
        onCall: () => _service.getRecommendedProduct(),
        onSuccess: (r) {
          return Right(r);
        },
        onFailure: (l) {
          return Left(l);
        });
  }
}
