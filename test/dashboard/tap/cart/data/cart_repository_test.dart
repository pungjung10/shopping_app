import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/cart_repository.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/model/product_request.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/remote/cart_service.dart';
import 'cart_repository_test.mocks.dart';

@GenerateMocks([CartService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockCartService mockCartService;
  late CartRepository repository;

  setUp(() {
    mockCartService = MockCartService();
    repository = CartRepositoryImpl(
      mockCartService,
    );
  });

  group('cart_repository_test', () {
    ProductRequest request = ProductRequest(products: []);

    test('Given checkOut success, Then it should return Right', () async {
      when(mockCartService.checkOut(any)).thenAnswer((_) async =>
          HttpResponse<void>(
            null,
            Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 200,
            ),
          )
      );

      final result = await repository.checkOut(request);

      expect(result.isRight(), true);
    });

    test('Given checkOut failure, then it should return Left', () async {
      when(mockCartService.checkOut(any)).thenAnswer((_) async =>
          HttpResponse<void>(
            null,
            Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 500,
              statusMessage: 'error',
            ),
          )
      );

      final result = await repository.checkOut(request);

      expect(result.isLeft(), true);
    });
  });
}
