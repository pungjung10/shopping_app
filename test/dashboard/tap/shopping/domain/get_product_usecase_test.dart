import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/src/core/base/failure.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/item_response.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/product_response.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/shopping_repository.dart';
import 'package:shopping_app/src/feature/shopping/product_list/domain/usecase/get_product_usecase.dart';

import 'get_product_usecase_test.mocks.dart';

@GenerateMocks([ShoppingRepository])
void main() {
  late MockShoppingRepository mockRepository;
  late GetProductUseCase getProductUseCase;

  setUp(() {
    mockRepository = MockShoppingRepository();
    getProductUseCase = GetProductUseCaseImpl(mockRepository);
  });

  group('get_product_usecase_test', () {
    const limit = 20;
    const cursor = "MjA=";

    final productResponse = ProductResponse(
      items: [
        ItemResponse(id: 1, name: "Product 1", price: 100),
        ItemResponse(id: 2, name: "Product 2", price: 200),
      ],
      nextCursor: "nextCursor",
    );

    test(
      'Given getProduct success, Then it should return right with ProductListModel',
          () async {
        when(mockRepository.getProduct(limit, cursor))
            .thenAnswer((_) async => Right(productResponse));

        final result = await getProductUseCase.execute(limit, cursor);

        result.fold(
              (l) => null,
              (r) => {
            expect(r.items.length, 2),
            expect(r.items.first.id, 1),
            expect(r.items.first.name, "Product 1"),
            expect(r.items.first.price, 100),
            expect(r.cursor, "nextCursor"),
          },
        );
      },
    );

    test(
      'Given getProduct success, When getProduct returns null data, Then it should return right with empty ProductListModel',
          () async {
        when(mockRepository.getProduct(limit, cursor))
            .thenAnswer((_) async => const Right(null));

        final result = await getProductUseCase.execute(limit, cursor);

        result.fold(
              (l) => null,
              (r) => {
            expect(r.items.isEmpty, true),
            expect(r.cursor, ""),
          },
        );
      },
    );

    test(
      'Given getProduct failure, Then it should return left with Failure',
          () async {
        when(mockRepository.getProduct(limit, cursor))
            .thenAnswer((_) async => const Left(Failure(errorMessage: "error")));

        final result = await getProductUseCase.execute(limit, cursor);

        result.fold(
              (l) => {
            expect(l.errorMessage, "error"),
          },
              (r) => null,
        );
      },
    );
  });
}
