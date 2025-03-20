import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/cart_repository.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/model/product_request.dart';
import 'package:shopping_app/src/dashboard/tab/cart/domain/usecase/checkout_usecase.dart';
import 'package:shopping_app/src/core/base/failure.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_usecase_test.mocks.dart';

@GenerateMocks([CartRepository])
void main() {
  late MockCartRepository mockRepository;
  late CheckOutUseCase checkOutUseCase;

  setUp(() {
    mockRepository = MockCartRepository();
    checkOutUseCase = CheckOutUseCaseImpl(mockRepository);
  });

  group('check_out_usecase_test', () {
    final productRequest = ProductRequest(products: []);

    test(
      'Given checkout success, When execute is called, Then it should return right with void',
      () async {
        when(mockRepository.checkOut(productRequest))
            .thenAnswer((_) async => const Right(null));

        final result = await checkOutUseCase.execute(productRequest);

        result.fold(
          (l) => null,
          (r) => null,
        );
      },
    );

    test(
      'Given checkout failure, Then it should return left with Failure',
      () async {
        when(mockRepository.checkOut(productRequest)).thenAnswer(
            (_) async => const Left(Failure(errorMessage: "Checkout failed")));

        final result = await checkOutUseCase.execute(productRequest);

        result.fold(
          (l) => {
            expect(l.errorMessage, "Checkout failed"),
          },
          (r) => null,
        );
      },
    );
  });
}
