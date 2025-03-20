import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/cart_repository.dart';
import 'package:shopping_app/src/dashboard/tab/cart/data/remote/cart_service.dart';
import 'package:shopping_app/src/dashboard/tab/cart/domain/usecase/calculate_total_price_usecase.dart';
import 'package:shopping_app/src/dashboard/tab/cart/domain/usecase/checkout_usecase.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/remote/shopping_service.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/shopping_repository.dart';
import 'package:shopping_app/src/feature/shopping/product_list/domain/usecase/get_product_usecase.dart';
import 'package:shopping_app/src/dashboard/tab/cart/presentation/bloc/cart_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_list/presentation/bloc/product_list_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_recommend_list/domain/usecase/get_recommended_product_usecase.dart';
import 'package:shopping_app/src/feature/shopping/product_recommend_list/presentation/bloc/recommended_product_list_bloc.dart';

import '../dashboard/tab/cart/presentation/checkout_bloc/checkout_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  final String baseUrl = _getBaseUrl();

  // SHOPPING
  sl.registerSingleton<ShoppingService>(
    ShoppingService(sl(), baseUrl: baseUrl),
  );
  sl.registerSingleton<ShoppingRepository>(ShoppingRepositoryImpl(sl()));

  sl.registerFactory<GetProductUseCase>(() => GetProductUseCaseImpl(sl()));
  sl.registerFactory<ProductListBloc>(() => ProductListBloc(sl()));

  sl.registerFactory<GetRecommendedProductUseCase>(() => GetRecommendedProductUseCaseImpl(sl()));
  sl.registerFactory<RecommendedProductListBloc>(() => RecommendedProductListBloc(sl()));

  // CART
  sl.registerSingleton<CartService>(
    CartService(sl(), baseUrl: "http://10.0.2.2:8080"),
  );
  sl.registerSingleton<CartRepository>(CartRepositoryImpl(sl()));

  sl.registerFactory<CalculateTotalPriceUseCase>(() => CalculateTotalPriceUseCaseImpl());
  sl.registerFactory<CheckOutUseCase>(() => CheckOutUseCaseImpl(sl()));
  sl.registerFactory<CartBloc>(() => CartBloc(sl()));
  sl.registerFactory<CheckoutBloc>(() => CheckoutBloc(sl()));
}

String _getBaseUrl() {
  if (Platform.isAndroid) {
    return "http://10.0.2.2:8080";
  } else {
    return "http://localhost:8080";
  }
}
