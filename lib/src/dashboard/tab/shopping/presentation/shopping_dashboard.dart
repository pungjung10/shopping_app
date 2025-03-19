import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/src/core/style/text_styles.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/presentation/bloc/shopping_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_list/presentation/bloc/product_list_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_recommend_list/presentation/bloc/recommended_product_list_bloc.dart';
import 'package:shopping_app/src/feature/shopping/product_recommend_list/presentation/recommended_product_list.dart';

import '../../../../feature/shopping/product_list/presentation/product_list.dart';

class ShoppingDashboard extends StatefulWidget {
  const ShoppingDashboard({super.key});

  @override
  State<ShoppingDashboard> createState() => _ShoppingDashboardState();
}

class _ShoppingDashboardState extends State<ShoppingDashboard> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<ProductListBloc>(context).add(ProductListLoadData(""));
    BlocProvider.of<RecommendedProductListBloc>(context).add(RecommendedProductListLoadData());
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      // The user is near the bottom (100px before reaching the end)
      print("Reached bottom, load more data...");
      // You can trigger a function to load more data here
      BlocProvider.of<ProductListBloc>(context).add(ProductListLoadMoreData(""));
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingBloc, ShoppingState>(
      builder: (context, state) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: const SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Recommend Product", style: fontTitleLarge),
                ),
                RecommendedProductList(),
                 Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Latest Products", style: fontTitleLarge),
                ),
                ProductList()
              ],
            ),
          ),
        );
      },
    );
  }
}
