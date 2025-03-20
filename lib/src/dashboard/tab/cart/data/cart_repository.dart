import 'package:dartz/dartz.dart';
import 'package:shopping_app/src/core/base/failure.dart';
import 'package:shopping_app/src/core/network/network_extension.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/model/product_request.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/remote/cart_service.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> checkOut(ProductRequest request);
}

class CartRepositoryImpl implements CartRepository {
  final CartService _service;

  CartRepositoryImpl(this._service);

  @override
  Future<Either<Failure, void>> checkOut(ProductRequest request) {
    return NetworkExtension.call(
        onCall: () => _service.checkOut(request),
        onSuccess: (r) {
          return Right(r);
        },
        onFailure: (l) {
          return Left(l);
        });
  }
}
