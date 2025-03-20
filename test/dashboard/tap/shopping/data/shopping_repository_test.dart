import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/item_response.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/product_response.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/remote/shopping_service.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/shopping_repository.dart';
import 'shopping_repository_test.mocks.dart';

@GenerateMocks([ShoppingService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockShoppingService mockShoppingService;
  late ShoppingRepository repository;

  setUp(() {
    mockShoppingService = MockShoppingService();
    repository = ShoppingRepositoryImpl(
      mockShoppingService,
    );
  });

  group('shopping_repository_test', () {
    const int limit = 20;
    const String cursor = "MjA=";
    final productResponse = ProductResponse();
    final List<ItemResponse> itemResponse = [];

    test('Given getProduct success, Then it should return Right', () async {
      when(mockShoppingService.getProduct(any, any)).thenAnswer((_) async =>
          HttpResponse<ProductResponse>(
              productResponse,
            Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 200,
            ),
          )
      );

      final result = await repository.getProduct(limit, cursor);

      expect(result.isRight(), true);
    });

    test('Given getProduct failure, then it should return Left', () async {
      when(mockShoppingService.getProduct(limit, cursor)).thenAnswer((_) async =>
          HttpResponse<ProductResponse?>(
            null,
            Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 500,
              statusMessage: 'error',
            ),
          )
      );

      final result = await repository.getProduct(limit, cursor);

      expect(result.isLeft(), true);
    });

    test('Given getRecommendedProduct success, Then it should return Right', () async {
      when(mockShoppingService.getRecommendedProduct()).thenAnswer((_) async =>
          HttpResponse<List<ItemResponse>>(
            itemResponse,
            Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 200,
            ),
          )
      );

      final result = await repository.getRecommendedProduct();

      expect(result.isRight(), true);
    });

    test('Given getRecommendedProduct failure, then it should return Left', () async {
      when(mockShoppingService.getRecommendedProduct()).thenAnswer((_) async =>
          HttpResponse<List<ItemResponse>?>(
            null,
            Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 500,
              statusMessage: 'error',
            ),
          )
      );

      final result = await repository.getRecommendedProduct();

      expect(result.isLeft(), true);
    });
  });
}
