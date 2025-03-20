import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/src/core/base/failure.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/item_response.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/shopping_repository.dart';
import 'package:shopping_app/src/feature/shopping/product_recommend_list/domain/usecase/get_recommended_product_usecase.dart';

import 'get_recommended_product_usecase_test.mocks.dart';

@GenerateMocks([ShoppingRepository])
void main() {
  late MockShoppingRepository mockRepository;
  late GetRecommendedProductUseCase getRecommendedProductUseCase;

  setUp(() {
    mockRepository = MockShoppingRepository();
    getRecommendedProductUseCase =
        GetRecommendedProductUseCaseImpl(mockRepository);
  });

  group('get_recommended_product_usecase_test', () {
    final recommendedProductResponse = [
      ItemResponse(id: 1, name: "Recommended Product 1", price: 100),
      ItemResponse(id: 2, name: "Recommended Product 2", price: 200),
    ];

    test(
      'Given getRecommendedProduct success, Then it should return right with a list of ItemModels',
      () async {
        when(mockRepository.getRecommendedProduct())
            .thenAnswer((_) async => Right(recommendedProductResponse));

        final result = await getRecommendedProductUseCase.execute();

        result.fold(
          (l) => null,
          (r) => {
            expect(r.length, 2),
            expect(r.first.id, 1),
            expect(r.first.name, "Recommended Product 1"),
            expect(r.first.price, 100),
            expect(r[1].id, 2),
            expect(r[1].name, "Recommended Product 2"),
            expect(r[1].price, 200),
          },
        );
      },
    );

    test(
      'Given getRecommendedProduct success, When getRecommendedProduct returns null data, Then it should return right with an empty list of ItemModels',
      () async {
        when(mockRepository.getRecommendedProduct())
            .thenAnswer((_) async => const Right(null));

        final result = await getRecommendedProductUseCase.execute();

        result.fold(
          (l) => null,
          (r) => {
            expect(r.isEmpty, true),
          },
        );
      },
    );

    test(
      'Given getRecommendedProduct failure, Then it should return left with Failure',
      () async {
        when(mockRepository.getRecommendedProduct()).thenAnswer(
            (_) async => const Left(Failure(errorMessage: "error")));

        final result = await getRecommendedProductUseCase.execute();

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
