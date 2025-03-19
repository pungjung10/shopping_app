import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/core/injection.dart';
import 'package:shopping_app/src/dashboard/dashboard_screen.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/presentation/bloc/shopping_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_item/presentation/bloc/product_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_list/presentation/bloc/product_list_bloc.dart';

import 'src/feature/shopping/product_recommend_list/presentation/bloc/recommended_product_list_bloc.dart';

Future<void> main() async {

  await initializeDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShoppingBloc(sl())),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => ProductListBloc(sl())),
        BlocProvider(create: (context) => RecommendedProductListBloc(sl())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}