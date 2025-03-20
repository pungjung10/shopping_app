import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/item_response.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/model/product_response.dart';

part 'shopping_service.g.dart';

@RestApi()
abstract class ShoppingService {
  factory ShoppingService(Dio dio, {required String baseUrl}) =>
      _ShoppingService(dio, baseUrl: baseUrl);

  @GET("/products")
  Future<HttpResponse<ProductResponse?>> getProduct(
      @Query("limit") int limit, @Query("cursor") String cursor);

  @GET("/recommended-products")
  Future<HttpResponse<List<ItemResponse>?>> getRecommendedProduct();
}
