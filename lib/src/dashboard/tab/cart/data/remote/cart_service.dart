import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/model/product_request.dart';

part 'cart_service.g.dart';

@RestApi()
abstract class CartService {
  factory CartService(Dio dio, {required String baseUrl}) =>
      _CartService(dio, baseUrl: baseUrl);

  @POST("/orders/checkout")
  Future<HttpResponse<void>> checkOut(
      @Body() ProductRequest model);
}
