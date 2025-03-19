import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/remote/shopping_service.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/data/shopping_repository.dart';
import 'package:shopping_app/src/feature/shopping/product_list/domain/usecase/get_product_usecase.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/presentation/bloc/shopping_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_list/presentation/bloc/product_list_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_recommend_list/domain/get_recommended_product_usecase.dart';
import 'package:shopping_app/src/feature/shopping/product_recommend_list/presentation/bloc/recommended_product_list_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());


  sl.registerSingleton<ShoppingService>(
    ShoppingService(sl(), baseUrl: "http://10.0.2.2:8080"),
  );
  sl.registerSingleton<ShoppingRepository>(ShoppingRepositoryImpl(sl()));

  sl.registerFactory<ShoppingBloc>(() => ShoppingBloc(sl()));

  sl.registerFactory<GetProductUseCase>(() => GetProductUseCaseImpl(sl()));
  sl.registerFactory<ProductListBloc>(() => ProductListBloc(sl()));

  sl.registerFactory<GetRecommendedProductUseCase>(() => GetRecommendedProductUseCaseImpl(sl()));
  sl.registerFactory<RecommendedProductListBloc>(() => RecommendedProductListBloc(sl()));
}
