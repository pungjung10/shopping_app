import 'package:dartz/dartz.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/cart_repository.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/model/product_request.dart';

import '../../../../../core/base/failure.dart';

abstract class CheckOutUseCase {
  Future<Either<Failure, void>> execute(ProductRequest request);
}

class CheckOutUseCaseImpl implements CheckOutUseCase {
  final CartRepository repository;

  CheckOutUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> execute(ProductRequest request) async {
    final response = await repository.checkOut(request);
    return response;
  }

}
